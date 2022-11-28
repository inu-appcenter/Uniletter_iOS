//
//  AlarmListVIewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit
import SnapKit

class NotiListViewController: UIViewController {
    
    let notiViewModel = NotiViewModel()
    
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
        
        infoButton.tintColor = UIColor.customColor(.lightGray)
        self.navigationItem.rightBarButtonItem = infoButton
    }
    
    func configureUI() {
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true

        collectionView.register(NotiListCell.self, forCellWithReuseIdentifier: NotiListCell.identifier)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func settingAPI() {
        DispatchQueue.main.async {
            self.notiViewModel.getAlarm {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func infoButtonClicked(_ sender: UIGestureRecognizer) {
        presentNoticeAlertView(noticeAlert: .notice, check: false)
    }
}

extension NotiListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notiViewModel.numOfcell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotiListCell.identifier, for: indexPath) as? NotiListCell else { return UICollectionViewCell() }
        
        cell.setUI(event: notiViewModel.eventAtIndex(index: indexPath.item))
        
        cell.bellClosure = {
            let alertViewController = AlertViewController()
            alertViewController.alert = .notification
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
            
            alertViewController.alertIsNotificationClosure = {
                self.notiViewModel.deleteAlarm(index: indexPath.item) {
                    self.settingAPI()
                    self.dismiss(animated: true)
                }
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let EventDetailVC = EventDetailViewController()
        EventDetailVC.id = notiViewModel.eventAtIndex(index: indexPath.item).id
        
        navigationController?.pushViewController(EventDetailVC, animated: true)
    }
}

extension NotiListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
    }
}

