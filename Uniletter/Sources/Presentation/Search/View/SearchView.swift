//
//  SearchView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/12/20.
//

import Foundation
import SnapKit

class SearchView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let height = UIScreen.main.bounds.width - CGFloat(20) * 2 - CGFloat(12)
        
        layout.itemSize = CGSize(width: height / 2, height: height)
        
        layout.sectionInset = UIEdgeInsets(top: 4, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        
        return collectionView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    
    func configureUI() {
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
