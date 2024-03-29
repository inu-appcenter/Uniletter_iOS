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

    private lazy var searchButton: UIButton = {
        let image = UIImage(named: "Search")
        
        let button = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: image!.size.width,
            height: image!.size.height))
        
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(goToSearch), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var myInfoButton: UIButton = {
        let image = UIImage(named: "person")
        
        let button = UIButton(frame: CGRect(
            x: 0,
            y: 0,
            width: image!.size.width,
            height: image!.size.height))
        
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(goToInfo), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Property
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    private let loginManager = LoginManager.shared
    private let eventStatusDropDown = DropDown()
    private let categoryDropDown = DropDown()
    
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
        let searchButtonItem = UIBarButtonItem(customView: searchButton)
        let infoButtonItem = UIBarButtonItem(customView: myInfoButton)

        self.navigationItem.leftBarButtonItems = [spacingItem(15), topLogo]
        self.navigationItem.rightBarButtonItems = [spacingItem(15), infoButtonItem, spacingItem(20), searchButtonItem]
    
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
        eventStatusDropDown.selectRow(1)
        eventStatusDropDown.selectionAction = { index, item in
            self.homeView.eventStatusButton.changeState(item)
            self.viewModel.eventStatus = index == 1
            self.scrollToTop()
            self.fetchEvents()
        }
        
        categoryDropDown.dataSource = viewModel.categoryList
        categoryDropDown.anchorView = homeView.categoryButton
        categoryDropDown.selectRow(at: 0)
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
    
    private func paging() {
        viewModel.isPaging = true
        fetchEvents()
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
    
    private func updateCellBookmark(_ cell: HomeCell, _ id: Int) {
        if loginManager.isLoggedIn {
            let like = cell.bookmarkButton.isSelected
            
            cell.bookmarkButton.isSelected = !like
            like ? viewModel.deleteLike(id) : viewModel.likeEvent(id)
        } else {
            presentLoginAlert(.loginLike)
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
            presentLoginAlert(.none)
        }
    }
    
    @objc private func goToWrite() {
        if loginManager.isLoggedIn {
            let vc = WritingViewController()
            vc.isSaved = true
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            presentLoginAlert(.loginWriting)
        }
    }
    
    @objc private func goToSearch() {
        
        let searchVC = SearchViewController()
        self.navigationController?.pushViewController(searchVC, animated: true)
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
        viewModel.isPull = true
        scrollToTop()
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
                self.updateCellBookmark(cell, event.id)
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
        if indexPath.item == viewModel.numOfEvents - 2 && !viewModel.isPaging {
            paging()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        
        if translation.y > 0 {  // Up
            homeView.showTopView()
        } else {                // Down
            homeView.hideTopView()
        }
    }
    
}
