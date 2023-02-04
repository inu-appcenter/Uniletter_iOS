//
//  SearchView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/12/20.
//

import Foundation
import SnapKit
import Then

class SearchView: UIView {
    
    // MARK: - UI
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 160)
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(SaveListCell.self, forCellWithReuseIdentifier: SaveListCell.identifier)
        
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    lazy var eventStatusButton = CategoryButton().then {
        $0.configureButton("전체")
    }
    
    lazy var categoryButton = CategoryButton().then {
        $0.configureButton("카테고리")
    }
    
    lazy var topView = UIView()
    
    // MARK: - Property
    
    private var isScrolling = false
    
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
        [eventStatusButton, categoryButton]
            .forEach { topView.addSubview($0) }
        
        [topView, collectionView]
            .forEach { addSubview($0) }
        
        topView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48)
        }

        categoryButton.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(32)
        }
        
        eventStatusButton.snp.makeConstraints {
            $0.centerY.height.equalTo(categoryButton)
            $0.right.equalTo(categoryButton.snp.left).offset(-4)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    private func updateTopViewHeight(_ isShow: Bool) {
        if !isScrolling {
            isScrolling = true
            
            topView.snp.updateConstraints {
                $0.height.equalTo(isShow ? 48 : 0)
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.layoutIfNeeded()
            }) { _ in
                self.isScrolling = false
            }
        }
    }
    
    func showTopView() {
        updateTopViewHeight(true)
    }
    
    func hideTopView() {
        updateTopViewHeight(false)
    }
}
