//
//  WritingDateView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/18.
//

import UIKit
import SnapKit

final class WritingDateView: UIView {
    
    // MARK: - UI
    let titleLabel = UILabel()
    
    lazy var dateTextField: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 4
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor.customColor(.defaultGray)
        textView.attributedText = showUnderline(convertTodayToString())
        textView.isUserInteractionEnabled = false
        
        return textView
    }()
    
    let bar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.defaultGray)
        
        return view
    }()
    
    lazy var timeTextField: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 4
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor.customColor(.defaultGray)
        textView.attributedText = showUnderline("6:00 PM")
        textView.isUserInteractionEnabled = false
        
        return textView
    }()
    
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
            dateTextField,
            bar,
            timeTextField,
        ]
            .forEach { addSubview($0) }
    }
    
    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        dateTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalTo(bar.snp.left).offset(-4)
            $0.height.equalTo(44)
        }
        
        bar.snp.makeConstraints {
            $0.centerY.equalTo(dateTextField)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(8)
            $0.height.equalTo(1)
        }
        
        timeTextField.snp.makeConstraints {
            $0.top.bottom.height.equalTo(dateTextField)
            $0.left.equalTo(bar.snp.right).offset(4)
            $0.right.equalToSuperview()
        }
    }
}
