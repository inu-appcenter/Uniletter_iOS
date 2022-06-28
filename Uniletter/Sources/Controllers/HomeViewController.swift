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
        setViewController()
        fetchEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addGradientLayer()
    }
    
    func configureNavigationBar() {
        let spaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spaceBarButtonItem.width = 15
        
        let topLogo = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        topLogo.setBackgroundImage(UIImage(named: "UniletterLabel"), for: .normal)
        topLogo.addTarget(self, action: #selector(didTaplogo), for: .touchUpInside)
        
        let myInfo = UIBarButtonItem(
            image: UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(gotoInfo))
        
        self.navigationItem.leftBarButtonItems = [spaceBarButtonItem, UIBarButtonItem(customView: topLogo)]
        self.navigationItem.rightBarButtonItem = myInfo
        
        let navigationBarLayer = self.navigationController?.navigationBar.layer
        navigationBarLayer?.shadowColor = CGColor.customColor(.lightGray)
        navigationBarLayer?.shadowOpacity = 0.2
        navigationBarLayer?.shadowOffset = CGSize(width: 0, height: 2.0)
    }
    
    func setViewController() {
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
    }
    
    func addGradientLayer() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0, 0.7, 1.0]
        gradient.frame = homeView.gradientView.bounds
        homeView.gradientView.layer.addSublayer(gradient)
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
