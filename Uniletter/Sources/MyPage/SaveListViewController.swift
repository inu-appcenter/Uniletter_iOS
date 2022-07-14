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
        
        return cell
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
