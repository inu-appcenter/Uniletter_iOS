//
//  HomeView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    
    // MARK: - UI
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 20
        let itemSpacing: CGFloat = 12
        
        let width = (UIScreen.main.bounds.width - margin * 2 - itemSpacing) / 2
        let height = width * 2
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        
        return collectionView
    }()
    
    lazy var writeButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.customColor(.lightBlue)
        config.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = config
        button.layer.shadowColor = UIColor.lightGray.cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 3, height: 3)
        button.setImage(UIImage(named: "Pencil"), for: .normal)
        
        return button
    }()
    
    let loadingIndicatorView = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setLayout()
    }
    
    // MARK: - Setup
    func addViews() {
        [
            collectionView,
            loadingIndicatorView,
        ]
            .forEach { addSubview($0) }
        
        addGradientLayer()
        
        addSubview(writeButton)
    }
    
    func addGradientLayer() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.9).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        ]
        let frame = UIScreen.main.bounds
        
        gradient.frame = CGRect(x: 0, y: frame.height - 115, width: frame.width, height: 115)
        layer.addSublayer(gradient)
    }
    
    func setLayout() {
        collectionView.snp.makeConstraints {
            $0.top.left.right.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.right.equalToSuperview().offset(-20)
            $0.width.height.equalTo(60)
        }
        
        loadingIndicatorView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(15)
            $0.left.right.equalTo(collectionView)
        }
    }
}
