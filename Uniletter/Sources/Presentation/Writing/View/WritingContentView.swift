//
//  WritingContentView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit
import Then

final class WritingContentView: BaseView {

    // MARK: - UI
    
    lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.text = "레터입력"
    }
    
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    lazy var titleView = createTextFieldView(.title)
    
    lazy var hostView = createTextFieldView(.host)
    
    lazy var categoryView = createTextFieldView(.category)
    
    lazy var targetView = createTextFieldView(.target)
    
    lazy var contactView = createTextFieldView(.contact)
    
    lazy var locationView = createTextFieldView(.link)
    
    lazy var eventStartView = createDateView(.start)
    
    lazy var eventEndView = createDateView(.end)
    
    lazy var categoryButton = UIButton().then {
        $0.backgroundColor = .clear
        $0.tintColor = .black
        $0.contentHorizontalAlignment = .right
        $0.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        $0.setImage(UIImage(systemName: "chevron.up"), for: .selected)
    }
    
    lazy var equalView = WritingCheckView().then {
        $0.label.text = "위와 동일"
        $0.checkButton.updateDefaultState()
    }
    
    lazy var recognizeTapView = UITapGestureRecognizer().then {
        $0.numberOfTapsRequired = 1
        $0.numberOfTouchesRequired = 1
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure
    
    override func configureView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addGestureRecognizer(recognizeTapView)
    }
    
    override func configureUI() {
        eventEndView.addSubview(equalView)
        
        [
            titleView,
            hostView,
            categoryView,
            targetView,
            eventStartView,
            eventEndView,
            contactView,
            locationView,
        ]
            .forEach { stackView.addArrangedSubview($0) }
        
        [
            titleLabel,
            stackView,
            categoryButton,
        ]
            .forEach { contentView.addSubview($0) }
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.top.left.right.equalTo(scrollView.contentLayoutGuide)
            $0.bottom.equalTo(scrollView.contentLayoutGuide).offset(-52)
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
            $0.right.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    private func createTextFieldView(_ subject: Subjects) -> WritingTextFieldView {
        return WritingTextFieldView().then {
            $0.titleLabel.text = subject.guideTitle
            
            switch subject {
            case .title, .target:
                $0.checkView.isHidden = true
            case .host:
                $0.textField.text = "ex)총학생회, 디자인학부"
                $0.textField.textColor = .customColor(.lightGray)
            case .category:
                $0.textField.text = "카테고리 선택"
                $0.textField.isUserInteractionEnabled = false
                $0.checkView.isHidden = true
            default:
                break
            }
        }
    }
    
    private func createDateView(_ subject: Subjects) -> WritingDateView {
        return WritingDateView().then {
            $0.titleLabel.text = subject == .start ? "행사시작을 입력해주세요." : "행사마감을 입력해주세요."
        }
    }
    
}
