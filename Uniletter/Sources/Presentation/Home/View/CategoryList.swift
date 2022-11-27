//
//  CategoryList.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/28.
//

import UIKit
import SnapKit

final class CategoryList: UIScrollView {
    
    // MARK: - UI
    
    lazy var contentView = UIView()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var resetButton: CategoryButton = {
        let button = createCategoryButtons("초기화")
        button.configuration?.image = UIImage(named: "reset")
        button.layer.borderColor = .customColor(.lightBlueGreen)
        
        return button
    }()
    
    lazy var progressingButton: CategoryButton = {
        let button = createCategoryButtons("진행중")
        button.configuration?.image = UIImage(named: "smallDown")
        
        return button
    }()
    
    lazy var groupButton = createCategoryButtons("동아리/소모임")
    lazy var councilButton = createCategoryButtons("학생회")
    lazy var snacksButton = createCategoryButtons("간식나눔")
    lazy var studyButton = createCategoryButtons("스터디")
    lazy var contestButton = createCategoryButtons("대회/공모전")
    lazy var offerButton = createCategoryButtons("구인")
    lazy var etcButton = createCategoryButtons("기타")
    
    // MARK: - Property
    
    var cnt = 0
    var buttons: [CategoryButton] = []
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        
        addViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func addViews() {
        [
            resetButton,
            progressingButton,
            groupButton,
            councilButton,
            snacksButton,
            studyButton,
            contestButton,
            offerButton,
            etcButton
        ]
            .forEach {
                stackView.addArrangedSubview($0)
            }
        
        contentView.addSubview(stackView)
        addSubview(contentView)
    }
    
    private func setLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalTo(contentLayoutGuide)
            $0.height.equalTo(frameLayoutGuide)
        }
        
        [
            resetButton,
            progressingButton,
            groupButton,
            councilButton,
            snacksButton,
            studyButton,
            contestButton,
            offerButton,
            etcButton
        ]
            .forEach {
                $0.snp.makeConstraints {
                    $0.height.equalTo(32)
                }
            }
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.left.right.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Func
    
    private func createCategoryButtons(_ title: String) -> CategoryButton {
        let button = CategoryButton()
        button.configureButton(title)
        button.tag = tag
        tag += 1
        
        return button
    }
    
}
