//
//  AlarmListVIewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit
import SnapKit

class AlarmListViewController: UIViewController {
    
    let alarmViewModel = AlarmViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        

        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        settingAPI()
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("알림 목록")
        
        let infoButton = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .done,
            target: self,
            action: #selector(infoButtonClicked(_:)))
        
        self.navigationItem.rightBarButtonItem = infoButton
    }
    
    func configureUI() {
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(AlarmListCell.self, forCellWithReuseIdentifier: AlarmListCell.identifier)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func settingAPI() {
        DispatchQueue.main.async {
            self.alarmViewModel.getAlarm {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func infoButtonClicked(_ sender: UIGestureRecognizer) {
        presentNoticeAlertView(.notice)
    }
}

extension AlarmListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alarmViewModel.numOfcell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlarmListCell.identifier, for: indexPath) as? AlarmListCell else { return UICollectionViewCell() }
        
        cell.setUI(event: alarmViewModel.eventAtIndex(index: indexPath.item))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let EventDetailVC = EventDetailViewController()
        EventDetailVC.id = alarmViewModel.eventAtIndex(index: indexPath.item).id
        
        navigationController?.pushViewController(EventDetailVC, animated: true)
    }
}

extension AlarmListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
    }
}

