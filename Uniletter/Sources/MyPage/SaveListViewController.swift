//
//  SaveListViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/14.
//

import UIKit
import SnapKit

class SaveListViewController: UIViewController {
    
    let saveListViewModel = SaveListViewModel()
    
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
        setAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setAPI()
    }
    func setAPI() {
        DispatchQueue.main.async {
            self.saveListViewModel.getLike {
                self.collectionView.reloadData()
            }
        }
    }
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("저장 목록")
    }
    
    func configureUI() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SaveListCell.self, forCellWithReuseIdentifier: SaveListCell.identifier)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension SaveListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return saveListViewModel.numOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaveListCell.identifier, for: indexPath) as? SaveListCell else { return UICollectionViewCell() }
        
        cell.setUI(event: saveListViewModel.eventAtIndex(index: indexPath.item))
        
        cell.bookMarkClosure = {
    
            let alertViewController = AlertViewController()
            alertViewController.alert = .save
            alertViewController.modalPresentationStyle = .overFullScreen
            alertViewController.modalTransitionStyle = .crossDissolve
            self.present(alertViewController, animated: true)
            
            alertViewController.alertIsSaveClosure = {
                
                self.saveListViewModel.deleteLike(index: indexPath.item) {
                    self.setAPI()
                    
                    NotificationCenter.default.post(
                        name: NSNotification.Name("like"),
                        object: nil,
                        userInfo: [
                            "id": self.saveListViewModel.eventAtIndex(index: indexPath.item).id,
                            "like": false
                        ])
                    
                    self.dismiss(animated: true)
                }
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let EventDetailVC = EventDetailViewController()
        EventDetailVC.id = saveListViewModel.eventAtIndex(index: indexPath.item).id
        navigationController?.pushViewController(EventDetailVC, animated: true)
    }
}

extension SaveListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
    }
}
