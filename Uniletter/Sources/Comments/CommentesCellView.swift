//
//  CommentesCellView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit
import SnapKit

class CommentsCellView: UIView {
    
    // MARK: - UI
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        
        return label
    }()
    
    let wroteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor.customColor(.blueGreen)
        label.textAlignment = .center
        label.isHidden = true
        
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ellipsisSmall"), for: .normal)
        
        return button
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 0
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .thin)
        label.textColor = UIColor.customColor(.lightGray)
        
        return label
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
            profileImageView,
            nicknameLabel,
            moreButton,
            contentLabel,
            dateLabel,
        ]
            .forEach { addSubview($0) }
    }
    
    func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(18)
            $0.left.equalToSuperview().offset(20)
            $0.width.height.equalTo(24)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        wroteLabel.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel)
            $0.left.equalTo(nicknameLabel.snp.right).offset(8)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview().offset(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(2)
            $0.bottom.equalToSuperview().offset(-12)
            $0.left.equalToSuperview().offset(20)
        }
    }
}
