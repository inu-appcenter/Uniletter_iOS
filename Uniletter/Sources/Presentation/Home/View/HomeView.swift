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
    
    lazy var eventStatusButton = createButton("전체")
    
    lazy var categoryButton = createButton("카테고리")
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 20
        let itemSpacing: CGFloat = 12
        
        let width = (UIScreen.main.bounds.width - margin * 2 - itemSpacing) / 2
        let height = width * 2
        layout.itemSize = CGSize(width: width, height: height)
        layout.sectionInset = UIEdgeInsets(top: 4, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.refreshControl = refreshControl
        collectionView.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
        
        return collectionView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshcontrol = UIRefreshControl()
        refreshcontrol.tintColor = .clear
        
        return refreshcontrol
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
    
    let loadingIndicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .large)
        indicatorView.hidesWhenStopped = true
        
        return indicatorView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func addViews() {
        [
            eventStatusButton,
            categoryButton,
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
        categoryButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16)
            $0.right.equalToSuperview().offset(-20)
            $0.width.greaterThanOrEqualTo(89)
            $0.height.equalTo(32)
        }
        
        eventStatusButton.snp.makeConstraints {
            $0.top.height.equalTo(categoryButton)
            $0.right.equalTo(categoryButton.snp.left).offset(-4)
            $0.width.greaterThanOrEqualTo(69)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(categoryButton.snp.bottom).offset(16)
            $0.left.right.bottom.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
            $0.right.equalToSuperview().offset(-20)
            $0.width.height.equalTo(60)
        }
        
        loadingIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    private func createButton(_ title: String) -> CategoryButton {
        let button = CategoryButton()
        button.configureButton(title)
        button.configuration?.image = UIImage(named: "smallDown")
        
        return button
    }
}
