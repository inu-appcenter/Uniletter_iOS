//
//  HomeViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import DropDown
import Firebase
import GoogleSignIn
import Then

final class HomeViewController: BaseViewController {
    
    // MARK: - UI
    
    private let topLogo = UIBarButtonItem().then {
        let imgView = UIImageView().then {
            $0.image = UIImage(named: "UniletterLabel")
            $0.contentMode = .scaleAspectFit
        }
        $0.customView = imgView
    }
    
    private lazy var myInfo = UIBarButtonItem(
        image: UIImage(
            systemName: "person",
            withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?
            .withRenderingMode(.alwaysOriginal),
        style: .done,
        target: self,
        action: #selector(goToInfo))
    
    // MARK: - Property
    
    let homeView = HomeView()
    let viewModel = HomeViewModel()
    let loginManager = LoginManager.shared
    let eventStatusDropDown = DropDown()
    let categoryDropDown = DropDown()
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin()
    }
    
    // MARK: - Configure
    
    override func configureNavigationBar() {
        self.navigationItem.leftBarButtonItems = [spacingItem(15), topLogo]
        self.navigationItem.rightBarButtonItems = [spacingItem(10), myInfo]
        
        addNavigationBarBorder()
    }
    
    override func configureViewController() {
        configureCollectionView()
        configureButtons()
        configureDropDowns()
        configureNotificationCenters()
    }
    
    private func configureCollectionView() {
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
        homeView.collectionView.refreshControl?.addTarget(
                    self,
                    action: #selector(didPullCollectionView(_:)),
                    for: .valueChanged)
    }
    
    private func configureButtons() {
        [homeView.eventStatusButton, homeView.categoryButton]
            .forEach { $0.changeCornerRadius() }
        
        homeView.eventStatusButton.addTarget(
            self,
            action: #selector(didTapEventStatusButton),
            for: .touchUpInside)
        homeView.categoryButton.addTarget(
            self,
            action: #selector(didTapCategoryButtons),
            for: .touchUpInside)
        homeView.writeButton.addTarget(
            self,
            action: #selector(goToWrite),
            for: .touchUpInside)
    }
    
    private func configureDropDowns() {
        eventStatusDropDown.dataSource = viewModel.eventStatusList
        eventStatusDropDown.anchorView = homeView.eventStatusButton
        eventStatusDropDown.selectionAction = { index, item in
            self.homeView.eventStatusButton.changeState(item)
            self.viewModel.eventStatus = index == 1
            self.scrollToTop()
            self.fetchEvents()
        }
        
        categoryDropDown.dataSource = viewModel.categoryList
        categoryDropDown.anchorView = homeView.categoryButton
        categoryDropDown.selectionAction = { index, item in
            self.homeView.categoryButton.changeState(item)
            self.viewModel.categoty = index
            self.scrollToTop()
            self.fetchEvents()
        }
        
        [eventStatusDropDown, categoryDropDown]
            .forEach {
                $0.configureDropDownAppearance()
                $0.cornerRadius = ($0.anchorView?.plainView.frame.height)! / 2
                $0.bottomOffset = CGPoint(x: 0, y: 40)
                $0.selectRow(at: 0)
            }
    }
    
    private func configureNotificationCenters() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateBookmark(_:)),
            name: NSNotification.Name("like"),
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadCollectionView(_:)),
            name: NSNotification.Name("HomeReload"),
            object: nil)
    }
    
    // MARK: - Funcs
    
    private func paging() {
        viewModel.isPaging = true
        fetchEvents()
    }
    
    private func fetchEvents() {
        if !viewModel.isPaging {
            setLoadingIndicator(true)
        }
        
        viewModel.loadEvents { [weak self] in
            DispatchQueue.main.async {
                self?.homeView.collectionView.reloadData()
                self?.setLoadingIndicator(false)
            }
        }
    }
    
    private func checkLogin() {
        if !loginManager.firstLogin {
            loginManager.checkLogin() { [weak self] in
                self?.fetchEvents()
                guard let isLoggedIn = self?.loginManager.isLoggedIn else {
                    print("checkLogin() - 로그인 상태: false")
                    return
                }
                
                print("checkLogin() - 로그인 상태: \(isLoggedIn)")
                if isLoggedIn {
                    self?.viewModel.postFCM()
                    self?.presentWaringView(.login)
                } else {
                    // 로그인 실패 시 남아있는 정보들 삭제(구글, 애플 꼬임 방지)
                    self?.loginManager.removeLoginInfo()
                }
            }
        } else {
            fetchEvents()
        }
        
    }
    
    private func setLoadingIndicator(_ bool: Bool) {
        if bool {
            homeView.loadingIndicatorView.startAnimating()
        } else {
            homeView.loadingIndicatorView.stopAnimating()
        }
        
        homeView.collectionView.isHidden = bool
    }
    
    private func scrollToTop() {
        homeView.collectionView.scrollToItem(
            at: IndexPath(item: -1, section: 0),
            at: .init(rawValue: 0),
            animated: true)
    }
    
    // MARK: - Action
    
    @objc private func didPullCollectionView(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        viewModel.isPull = true
        fetchEvents()
    }
    
    @objc private func didTapEventStatusButton() {
        eventStatusDropDown.show()
    }
    
    @objc private func didTapCategoryButtons() {
        categoryDropDown.show()
    }
    
    @objc private func goToInfo() {
        if loginManager.isLoggedIn {
            let myPageViewController = MyPageViewController()
            self.navigationController?.pushViewController(myPageViewController, animated: true)
            
            myPageViewController.logoutCompletionClosure = {
                self.checkLogin()
                self.presentWaringView(.logout)
            }
        } else {
            presentAlertView(.login)
        }
    }
    
    @objc private func goToWrite() {
        if loginManager.isLoggedIn {
            let vc = WritingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let AlertView = AlertVC(.login)
            present(AlertView, animated: true)

            AlertView.cancleButtonClosure = {
                self.presentWaringView(.loginWriting)
            }
        }
    }
    
    @objc private func updateBookmark(_ noti: NSNotification) {
        guard let like = noti.userInfo?["like"],
              let id = noti.userInfo?["id"] else {
            return
        }
        
        viewModel.updateLikes(id as! Int, like as! Bool)
        homeView.collectionView.reloadData()
    }
    
    @objc private func reloadCollectionView(_ noti: NSNotification) {
        fetchEvents()
    }
}

// MARK: - CollectionView
extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int)
    -> Int
    {
        return viewModel.numOfEvents
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HomeCell.identifier,
            for: indexPath) as? HomeCell else {
            return UICollectionViewCell()
        }
        
        if viewModel.numOfEvents > 0 {
            let event = viewModel.infoOfEvent(indexPath.item)
            cell.updateCell(event)
            
            cell.bookmarkButtonTapHandler = {
                if self.loginManager.isLoggedIn {
                    let like = cell.bookmarkButton.isSelected
                    cell.bookmarkButton.isSelected = !like
                    if like {
                        self.viewModel.deleteLike(event.id)
                    } else {
                        self.viewModel.likeEvent(event.id)
                    }
                } else {
                    let alertView = self.AlertVC(.login)
                    self.present(alertView, animated: true)
                    alertView.cancleButtonClosure = {
                        self.presentWaringView(.loginLike)
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath)
    {
            let vc = EventDetailViewController()
            let event = viewModel.infoOfEvent(indexPath.item)
            vc.id = event.id
            
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath)
    {
        let index = indexPath.item
        
        if index == viewModel.numOfEvents - 2 && !viewModel.isPaging {
            paging()
        }
    }
    
}
