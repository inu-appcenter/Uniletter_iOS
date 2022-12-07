//
//  CommentsCell.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class CommentsCell: UITableViewCell {
    
    static let identifier = "commentsCell"
    
    // MARK: - UI
    
    private lazy var profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 12
        $0.clipsToBounds = true
    }
    
    private lazy var nicknameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private lazy var wroteLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.text = "글쓴이"
        $0.textColor = .customColor(.blueGreen)
        $0.textAlignment = .center
        $0.layer.cornerRadius = 10.5
        $0.layer.borderColor = .customColor(.blueGreen)
        $0.layer.borderWidth = 1
        $0.isHidden = true
    }
    
    private lazy var moreButton = UIButton().then {
        $0.setImage(UIImage(named: "ellipsisSmall"), for: .normal)
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .thin)
        $0.numberOfLines = 0
        $0.lineBreakMode = .byCharWrapping
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 11, weight: .light)
        $0.textColor = .customColor(.darkGray)
    }
    
    // MARK: - Property
    
    var moreButtonTapHandler: (() -> Void)?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configureCell() {
        configureUI()
        configureLayout()
        
        selectionStyle = .none
        
        moreButton.addTarget(
            self,
            action: #selector(didTapMoreButton(_:)),
            for: .touchUpInside)
    }
    
    private func configureUI() {
        [
            profileImageView,
            nicknameLabel,
            wroteLabel,
            moreButton,
            contentLabel,
            dateLabel,
        ]
            .forEach { contentView.addSubview($0) }
    }
    
    private func configureLayout() {
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
            $0.width.equalTo(56)
            $0.height.equalTo(21)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.right.equalToSuperview().offset(-20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-30)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-40)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(4)
            $0.left.equalToSuperview().offset(20)
        }
    }
    
    // MARK: - Func
    
    private func updateProfileImage(_ imgURL: String?) {
        if let imgURL = imgURL,
           let url = URL(string: imgURL) {
            profileImageView.kf.setImage(with: url)
        } else {
            profileImageView.image = UIImage(named: "UserImage")
        }
    }
    
    func updateUI(comment: Comment, id: Int) {
        updateProfileImage(comment.profileImage)
        nicknameLabel.text = comment.nickname
        contentLabel.text = comment.content
        dateLabel.text = CustomFormatter.convertISO8601DateToString(
            comment.createdAt,
            "yy. MM. dd HH:mm")
        wroteLabel.isHidden = comment.userID == id ? false : true
    }
    
    // MARK: - Action
    
    @objc func didTapMoreButton(_ sender: UIButton) {
        moreButtonTapHandler?()
    }
    
}
