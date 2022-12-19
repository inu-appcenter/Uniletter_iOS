//
//  WritingDetailView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit
import Then

final class WritingDetailView: BaseView {

    // MARK: - UI
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.text = "상세레터"
    }

    private lazy var subTitleLabel = UILabel().then {
        $0.text = "상세 내용을 입력해 주세요."
        $0.font = .systemFont(ofSize: 14)
    }
    
    lazy var textField = UITextView().then {
        $0.writingTextView()
        $0.text = "하위 게시물이나 부적절한 언어 사용 시\n유니레터 이용이 어려울 수 있습니다."
        $0.textColor = UIColor.customColor(.defaultGray)
        $0.textContainer.lineBreakMode = .byCharWrapping
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    private lazy var guideLabel = UILabel().then {
        $0.text = "8000자 이내로 입력 가능합니다."
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor.customColor(.defaultGray)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureUI() {
        [
            titleLabel,
            subTitleLabel,
            textField,
            guideLabel
        ]
            .forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalTo(titleLabel)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(4)
            $0.left.right.equalTo(titleLabel)
            $0.height.equalTo(280)
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(4)
            $0.left.right.equalTo(titleLabel)
        }
    }
    
}
