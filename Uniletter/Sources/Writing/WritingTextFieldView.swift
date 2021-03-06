//
//  WritingTextFieldView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit

final class WritingTextFieldView: UIView {

    // MARK: - UI
    let titleLabel = UILabel()
    
    lazy var textField: UITextView = {
        let textView = UITextView()
        textView.writingTextView()
        textView.textContainer.maximumNumberOfLines = 1
        textView.textContainer.lineBreakMode = .byTruncatingHead
        textView.textContainerInset = UIEdgeInsets(
            top: 12,
            left: 16,
            bottom: 10,
            right: 16)
        
        return textView
    }()
    
    let checkView = WritingCheckView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
            titleLabel,
            textField,
            checkView
        ]
            .forEach { addSubview($0) }
    }
    
    func setLayout() {
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
