//
//  HomeViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import GoogleSignIn
import Firebase

final class HomeViewController: UIViewController {
    
    // MARK: - Property
    let homeView = HomeView()
    let viewModel = HomeViewModel()
    let loginManager = LoginManager.shared
    
    // MARK: - Life cycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViewController()
        checkLogin()
    }
    
    // MARK: - Setup
    func setNavigationBar() {
        let topLogo: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
            button.setBackgroundImage(
                UIImage(named: "UniletterLabel"),
                for: .normal)
            button.isUserInteractionEnabled = false
            
            return button
        }()
        
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let myInfo = UIBarButtonItem(
            image: UIImage(
                systemName: "person", withConfiguration: config)?
                .withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(goToInfo))
        
        self.navigationItem.leftBarButtonItems = [
            spacingItem(15),
            UIBarButtonItem(customView: topLogo),
        ]
        self.navigationItem.rightBarButtonItems = [
            spacingItem(10),
            myInfo,
        ]
        
        let navigationBarLayer = self.navigationController?.navigationBar.layer
        navigationBarLayer?.shadowColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
        navigationBarLayer?.shadowOpacity = 0.6
        navigationBarLayer?.shadowOffset = CGSize(width: 0, height: 5)
        setNavigationGesutre()
    }
    
    func setViewController() {
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
        homeView.collectionView.refreshControl = UIRefreshControl()
        homeView.collectionView.refreshControl?.addTarget(
                    self,
                    action: #selector(didPullCollectionView(_:)),
                    for: .valueChanged)
        
        homeView.writeButton.addTarget(
            self,
            action: #selector(goToWrite(_:)),
            for: .touchUpInside)
        
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
    
    func paging() {
        viewModel.isPaging = true
        print("paging")
        print("page: \(viewModel.currentPage)")
        fetchEvents()
    }
    
    func fetchEvents() {
        viewModel.loadEvents {
            DispatchQueue.main.async {
                self.homeView.collectionView.reloadData()
                self.homeView.collectionView.refreshControl?.endRefreshing()
                self.setLoadingIndicator(false)
            }
        }
    }
    
    func checkLogin() {
        setLoadingIndicator(true)
        
        if !loginManager.firstLogin {
            loginManager.checkLogin() {
                self.paging()
                print("checkLogin() - 로그인 상태: \(self.loginManager.isLoggedIn)")
                if self.loginManager.isLoggedIn {
                    self.viewModel.postFCM()
                    self.presentWaringView(.login)
                } else {
                    // 로그인 실패 시 남아있는 정보들 삭제(구글, 애플 꼬임 방지)
                    UserDefaults.standard.removeObject(forKey: "GoogleLoginInfo")
                    UserDefaults.standard.removeObject(forKey: "AppleLoginInfo")
                }
            }
        } else {
            self.paging()
        }
        
    }
    
    func setLoadingIndicator(_ bool: Bool) {
        if bool {
            homeView.loadingIndicatorView.isHidden = false
            homeView.collectionView.isHidden = true
            homeView.loadingIndicatorView.startAnimating()
        } else {
            homeView.loadingIndicatorView.isHidden = true
            homeView.collectionView.isHidden = false
            homeView.loadingIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Action
    
    @objc func didPullCollectionView(_ refreshControl: UIRefreshControl) {
        viewModel.isPull = true
        paging()
    }
    
    @objc func goToInfo(_ sender: UIBarButtonItem) {
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
    
    @objc func goToWrite(_ sender: UIButton) {
        if loginManager.isLoggedIn {
            let writingViewController = WritingViewController()
            self.navigationController?.pushViewController(writingViewController, animated: true)
        } else {
            let AlertView = AlertVC(.login)
            present(AlertView, animated: true)

            AlertView.cancleButtonClosure = {
                self.presentWaringView(.loginWriting)
            }
        }
    }
    
    @objc func updateBookmark(_ noti: NSNotification) {
        guard let like = noti.userInfo?["like"],
              let id = noti.userInfo?["id"] else {
            print("실패")
            
            return }
        
        viewModel.updateBookmarkButton(id: id as! Int, isChecked: like as! Bool)
        homeView.collectionView.reloadData()
    }
    
    @objc func reloadCollectionView(_ noti: NSNotification) {
        setLoadingIndicator(true)
        fetchEvents()
    }
}

// MARK: - CollectionView
extension HomeViewController: UICollectionViewDelegate,
                              UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int)
    -> Int {
        return viewModel.numOfEvents
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
    -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else { return UICollectionViewCell() }
        
        let event = viewModel.infoOfEvent(indexPath.item)
        cell.setUI(event)
        
        cell.bookmarkButtonTapHandler = {
            if self.loginManager.isLoggedIn {
                let like = cell.homeCellView.bookmarkButton.isSelected
                cell.homeCellView.bookmarkButton.isSelected = !like
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
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath) {
            let eventDetailViewController = EventDetailViewController()
            let event = viewModel.events[indexPath.item]
            eventDetailViewController.id = event.id
            
            self.navigationController?.pushViewController(eventDetailViewController, animated: true)
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

extension HomeViewController: UIGestureRecognizerDelegate {
    
    func setNavigationGesutre() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}
