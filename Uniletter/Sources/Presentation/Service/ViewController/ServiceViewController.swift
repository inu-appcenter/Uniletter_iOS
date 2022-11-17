//
//  ServiceViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/11/10.
//

import Foundation
import UIKit
import SnapKit

class ServiceViewController: UIViewController {
    
    let viewModel = ServiceViewModel()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(PrivacyPolicyCell.self, forCellWithReuseIdentifier: PrivacyPolicyCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureUI()
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("서비스 이용약관")
    }
    
    func configureUI() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension ServiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrivacyPolicyCell.identifier, for: indexPath) as? PrivacyPolicyCell else { return UICollectionViewCell() }
        
        cell.updateUI(viewModel.service[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
}

extension ServiceViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = viewModel.sizeOfCell(index: indexPath.item, width: view.frame.size.width)
                
        return CGSize(width: view.frame.size.width, height: height)
        
    }
}
