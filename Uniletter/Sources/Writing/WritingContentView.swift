//
//  WritingContentView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit

final class WritingContentView: UIView {

    // MARK: - UI
    lazy var scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "레터입력"
        
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        
        return stackView
    }()
    
    lazy var titleView: WritingTextFieldView = {
        let view = WritingTextFieldView()
        view.titleLabel.writingTitle("제목을 입력해주세요.")
        view.checkView.isHidden = true
        
        return view
    }()
    
    lazy var hostView: WritingTextFieldView = {
        let view = WritingTextFieldView()
        view.titleLabel.writingTitle("소속된 단체를 입력해주세요.")
        view.textField.text = "ex)총학생회, 디자인학부"
        view.textField.textColor = UIColor.customColor(.lightGray)
        
        return view
    }()
    
    lazy var categoryView: WritingTextFieldView = {
        let view = WritingTextFieldView()
        view.titleLabel.writingTitle("카테고리를 선택해주세요.")
        view.textField.text = "카테고리 선택"
        view.textField.isUserInteractionEnabled = false
        view.checkView.isHidden = true
        
        return view
    }()
    
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.tintColor = .black
        button.contentHorizontalAlignment = .right
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.setImage(UIImage(systemName: "chevron.up"), for: .selected)
        
        return button
    }()
    
    lazy var targetView: WritingTextFieldView = {
        let view = WritingTextFieldView()
        view.titleLabel.writingTitle("모집대상을 입력해주세요.")
        view.checkView.isHidden = true
        
        return view
    }()
    
    lazy var eventStartView: WritingDateView = {
        let view = WritingDateView()
        view.titleLabel.writingTitle("행사시작을 입력해주세요.")
        
        return view
    }()
    
    lazy var eventEndView: WritingDateView = {
        let view = WritingDateView()
        view.titleLabel.writingTitle("행사마감을 입력해주세요.")
        
        return view
    }()
    
    lazy var equalView: WritingCheckView = {
        let view = WritingCheckView()
        view.label.writingDefault("위와 동일")
        view.checkButton.isSelected = false
        view.checkButton.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
        view.checkButton.backgroundColor = .white
        
        return view
    }()
    
    lazy var contactView: WritingTextFieldView = {
        let view = WritingTextFieldView()
        view.titleLabel.writingTitle("문의사항시 연락방법을 입력해주세요.")
        
        return view
    }()
    
    lazy var locationView: WritingTextFieldView = {
        let view = WritingTextFieldView()
        view.titleLabel.writingTitle("첨부할 URL이 있다면 입력해주세요.")
        
        return view
    }()
    
    let clearView = UIView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setLayout()
    }

    // MARK: - Setup
    func addViews() {
        [
            titleView,
            hostView,
            categoryView,
            targetView,
            eventStartView,
            eventEndView,
            contactView,
            locationView,
            clearView,
        ]
            .forEach { stackView.addArrangedSubview($0) }
        
        [
            titleLabel,
            equalView,
            stackView,
            categoryButton,
        ]
            .forEach { contentView.addSubview($0) }
        
        scrollView.addSubview(contentView)
        
        addSubview(scrollView)
    }
    
    func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.equalToSuperview().offset(20)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().offset(-24)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        categoryButton.snp.makeConstraints {
            $0.bottom.equalTo(categoryView)
            $0.left.equalTo(categoryView)
            $0.right.equalTo(categoryView).offset(-15)
            $0.height.equalTo(44)
        }
        
        equalView.snp.makeConstraints {
            $0.centerY.equalTo(eventEndView.titleLabel)
            $0.right.equalToSuperview().offset(-20)
        }
        
        clearView.setContentHuggingPriority(.init(rawValue: 100), for: .vertical)
        
    }
}
