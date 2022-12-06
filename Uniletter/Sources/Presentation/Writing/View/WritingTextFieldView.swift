//
//  WritingTextFieldView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit
import Then

final class WritingTextFieldView: BaseView {

    // MARK: - UI
    
    lazy var titleLabel = UILabel()
    
    lazy var textField = UITextView().then {
        $0.writingTextView()
        $0.textContainer.maximumNumberOfLines = 1
        $0.textContainer.lineBreakMode = .byTruncatingHead
        $0.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 10, right: 16)
    }
    
    lazy var checkView = WritingCheckView()
    
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
            textField,
            checkView
        ]
            .forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        checkView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.right.equalToSuperview()
        }
    }
}
