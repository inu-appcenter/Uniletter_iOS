//
//  AgreeDetailView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/10.
//

import UIKit
import SnapKit

final class AgreeDetailView: UIView {
    
    // MARK: - UI
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        
        return label
    }()

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(
            UIImage(systemName: "xmark"),
            for: .normal)
        button.tintColor = .black
        
        return button
    }()

    let textView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 13)
        textView.isEditable = false
        
        return textView
    }()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setLayout()
    }

    // MARK: - Setup

    func addViews() {
        [
            titleLabel,
            cancelButton,
            textView
        ]
            .forEach { addSubview($0) }
    }

    func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.left.equalToSuperview().offset(20)
            $0.width.height.equalTo(30)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().offset(-20)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
}


