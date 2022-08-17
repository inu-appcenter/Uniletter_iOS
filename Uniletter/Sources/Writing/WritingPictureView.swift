//
//  WritingPictureView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit

final class WritingPictureView: UIView {
    
    // MARK: - UI
    let scrollView = UIScrollView()
    
    let contentView = UIView()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "사진등록"
        
        return label
    }()
    
    lazy var imageButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor.customColor(.lightGray)
        button.setImage(UIImage(named: "uniletter_big"), for: .normal)
        button.clipsToBounds = true
        
        return button
    }()
    
    let defaultLabel: UILabel = {
        let label = UILabel()
        label.writingTitle("없음 선택 시 기본 이미지가 등록됩니다.")
        label.textColor = UIColor.customColor(.defaultGray)
        
        return label
    }()
    
    lazy var checkView = WritingCheckView()
    
    let clearView = UIView()
    
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
            imageButton,
            defaultLabel,
            checkView,
            clearView,
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
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        imageButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalTo(titleLabel)
            $0.height.equalTo(imageButton.snp.width).multipliedBy(sqrt(2))
        }
        
        defaultLabel.snp.makeConstraints {
            $0.top.equalTo(imageButton.snp.bottom).offset(8)
            $0.left.equalTo(titleLabel)
        }
        
        checkView.snp.makeConstraints {
            $0.top.equalTo(defaultLabel)
            $0.right.equalTo(titleLabel)
        }
        
        clearView.snp.makeConstraints {
            $0.top.equalTo(defaultLabel.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
    }
}
