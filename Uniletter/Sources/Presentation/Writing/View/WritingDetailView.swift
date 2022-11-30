//
//  WritingDetailView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit

final class WritingDetailView: UIView {

    // MARK: - UI
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "상세레터"
        
        return label
    }()

    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.writingTitle("상세 내용을 입력해 주세요.")
        
        return label
    }()
    
    lazy var textField: UITextView = {
        let textView = UITextView()
        textView.writingTextView()
        textView.text = "하위 게시물이나 부적절한 언어 사용 시\n유니레터 이용이 어려울 수 있습니다."
        textView.textColor = UIColor.customColor(.defaultGray)
        textView.textContainer.lineBreakMode = .byCharWrapping
        textView.textContainerInset = UIEdgeInsets(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16)
        
        return textView
    }()
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.writingTitle("8000자 이내로 입력 가능합니다.")
        label.textColor = UIColor.customColor(.defaultGray)
        
        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
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
            subTitleLabel,
            textField,
            guideLabel
        ]
            .forEach { addSubview($0) }
    }
    
    func setLayout() {
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
