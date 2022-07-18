//
//  PrivacyPolicyViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/13.
//

import UIKit
import SnapKit

class PrivacyPolicyViewController: UIViewController {
    
    
    let viewModel = PrivacyPolicyViewModel()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView

    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        configureNavigationBar()
        configureUI()
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("개인정보 처리방침")
    }
    
    func configureUI() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(PrivacyPolicyCell.self, forCellWithReuseIdentifier: PrivacyPolicyCell.identifier)
        
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension PrivacyPolicyViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrivacyPolicyCell.identifier, for: indexPath) as? PrivacyPolicyCell else { return UICollectionViewCell() }
        
        cell.titleLabel.text = viewModel.titleOfPolicy(index: indexPath.item)
        cell.bodyLabel.text = viewModel.bodyOfPolicy(index: indexPath.item)
                
        return cell
    }
}

extension PrivacyPolicyViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let height = viewModel.sizeOfCell(index: indexPath.item, width: view.frame.size.width)
                
        return CGSize(width: view.frame.size.width, height: height)
    }
}
