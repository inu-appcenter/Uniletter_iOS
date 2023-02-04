//
//  HomeView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import SnapKit
import Then

final class HomeView: BaseView {
    
    // MARK: - UI
    
    lazy var eventStatusButton = CategoryButton().then {
        $0.configureButton("진행중")
    }
    
    lazy var categoryButton = CategoryButton().then {
        $0.configureButton("카테고리")
    }
    
    lazy var topView = UIView()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.refreshControl = refreshControl
        $0.register(HomeCell.self, forCellWithReuseIdentifier: HomeCell.identifier)
    }
    
    lazy var refreshControl = UIRefreshControl().then {
        $0.tintColor = .clear
    }
    
    lazy var writeButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.customColor(.lightBlue)
        config.cornerStyle = .capsule
        
        $0.configuration = config
        $0.layer.shadowColor = UIColor.lightGray.cgColor
        $0.layer.shadowOpacity = 1.0
        $0.layer.shadowOffset = CGSize(width: 3, height: 3)
        $0.setImage(UIImage(named: "Pencil"), for: .normal)
    }
    
    lazy var loadingIndicatorView = UIActivityIndicatorView(style: .large).then {
        $0.hidesWhenStopped = true
    }
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        let margin: CGFloat = 20
        let itemSpacing: CGFloat = 12
        let height = UIScreen.main.bounds.width - margin * 2 - itemSpacing
        
        $0.itemSize = CGSize(width: height / 2, height: height)
        $0.sectionInset = UIEdgeInsets(top: 4, left: 20, bottom: 0, right: 20)
    }
    
    private let gradientLayer = CAGradientLayer().then {
        let frame = UIScreen.main.bounds
        
        $0.colors = [
            UIColor(red: 1, green: 1, blue: 1, alpha: 0).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.3).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 0.9).cgColor,
            UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        ]
        
        $0.frame = CGRect(x: 0, y: frame.height - 115, width: frame.width, height: 115)
    }
    
    // MARK: - Property
    
    private var isScrolling = false
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureUI() {
        [eventStatusButton, categoryButton]
            .forEach { topView.addSubview($0) }
        
        [
            topView,
            collectionView,
            loadingIndicatorView,
        ]
            .forEach { addSubview($0) }
        
        layer.addSublayer(gradientLayer)
        addSubview(writeButton)
    }
    
    override func configureLayout() {
        topView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(64)
        }
        
        categoryButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalToSuperview().multipliedBy(0.5)
        }
        
        eventStatusButton.snp.makeConstraints {
            $0.centerY.height.equalTo(categoryButton)
            $0.right.equalTo(categoryButton.snp.left).offset(-4)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom)
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
    
    private func updateTopViewHeight(_ isShow: Bool) {
        if !isScrolling {
            isScrolling = true
            
            topView.snp.updateConstraints {
                $0.height.equalTo(isShow ? 64 : 0)
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
