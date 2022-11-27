//
//  CategoryList.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/28.
//

import UIKit
import SnapKit

enum Category: Int {
    case group = 1
    case council = 2
    case snacks = 3
    case contest = 4
    case study = 5
    case offer = 6
    case etc = 7
    case lecture = 8
    case reset = 100
    case progressing = 101
    
    var title: String {
        switch self {
        case .group: return "동아리/소모임"
        case .council: return "학생회"
        case .snacks: return "간식나눔"
        case .contest: return "대회/공모전"
        case .study: return "스터디"
        case .offer: return "구인"
        case .etc: return "기타"
        case .lecture: return "교육/강연"
        case .reset: return "초기화"
        case .progressing: return "진행중"
        }
    }
}

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
        let button = createCategoryButtons(.reset)
        button.configuration?.image = UIImage(named: "reset")
        button.layer.borderColor = .customColor(.lightBlueGreen)
        button.isHidden = true
        
        return button
    }()
    
    lazy var progressingButton: CategoryButton = {
        let button = createCategoryButtons(.progressing)
        button.configuration?.image = UIImage(named: "smallDown")
        
        return button
    }()
    
    lazy var groupButton = createCategoryButtons(.group)
    lazy var councilButton = createCategoryButtons(.council)
    lazy var snacksButton = createCategoryButtons(.snacks)
    lazy var studyButton = createCategoryButtons(.study)
    lazy var contestButton = createCategoryButtons(.contest)
    lazy var offerButton = createCategoryButtons(.offer)
    lazy var etcButton = createCategoryButtons(.etc)
    
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
    
    private func createCategoryButtons(_ category: Category) -> CategoryButton {
        let button = CategoryButton()
        button.configureButton(category.title)
        button.tag = category.rawValue
        
        return button
    }
    
}
