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
        
        layout.itemSize = CGSize(width: view.frame.size.width, height: 160)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        fetchLike()
    }

    func fetchLike() {
        saveListViewModel.getLike {
            DispatchQueue.main.async {
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
        collectionView.alwaysBounceVertical = true
        
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let index = indexPath.item
        
        if index == saveListViewModel.numOfCell - 1 && !saveListViewModel.isLast {
            fetchLike()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaveListCell.identifier, for: indexPath) as? SaveListCell else { return UICollectionViewCell() }

        cell.setUI(event: saveListViewModel.eventAtIndex(index: indexPath.item))

        cell.bookMarkClosure = {

            let alertViewController = self.AlertVC(.save)
            self.present(alertViewController, animated: true)

            alertViewController.alertIsSaveClosure = {
                
                self.saveListViewModel.deleteLike(index: indexPath.item) {

                    self.collectionView.reloadData()
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
        
        EventDetailVC.userLikeCompletionClosure = {
            $0 ? self.saveListViewModel.likeEvent(index: indexPath.item, id: EventDetailVC.id) : self.saveListViewModel.deleteLikeEvent(EventDetailVC.id)
            self.collectionView.reloadData()

        }
    }
}
