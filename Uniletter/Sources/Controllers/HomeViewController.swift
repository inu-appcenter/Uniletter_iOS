//
//  HomeViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit

class HomeViewController: UIViewController {

    let homeView = HomeView()
    let eventManager = EventManager.shared
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        setController()
        fetchEvents()
    }
    
    func configureNavigationBar() {
        let logo = UIBarButtonItem(
            image: UIImage(named: "Logo2")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(didTaplogo))
        self.navigationItem.leftBarButtonItem = logo
        
        let myInfo = UIBarButtonItem(
            image: UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(gotoInfo))
        self.navigationItem.rightBarButtonItem = myInfo
    }
    
    func setController() {
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
    }
    
    func fetchEvents() {
        DispatchQueue.global().async {
            API.getEvents() { events in
                self.eventManager.events = events
                DispatchQueue.main.async {
                    self.eventManager.formatEndAt()
                    self.homeView.collectionView.reloadData()
                }
            }
        }
    }
    
    @objc func didTaplogo() {
        // TODO: 최상단 이동 후 리로드
    }
    
    @objc func gotoInfo() {
        // TODO: 내 정보 표시
        let myPageViewController = MyPageViewController()
        
        self.navigationController?.pushViewController(myPageViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventManager.numOfEvents
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else { return UICollectionViewCell() }
        
        let event = eventManager.infoOfEvent(indexPath.row)
        cell.setUI(event)
        
        return cell
    }
    
    
}
