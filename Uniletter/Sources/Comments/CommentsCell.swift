//
//  CommentsCell.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit
import SnapKit
import Kingfisher

final class CommentsCell: UITableViewCell {
    
    static let identifier = "commentsCell"
    
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
        label.text = "글쓴이"
        label.textColor = UIColor.customColor(.blueGreen)
        label.textAlignment = .center
        label.layer.cornerRadius = 10.5
        label.layer.borderColor = CGColor.customColor(.blueGreen)
        label.layer.borderWidth = 1
        
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
        label.lineBreakMode = .byCharWrapping
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.textColor = UIColor.customColor(.darkGray)
        
        return label
    }()
    
    // MARK: - Property
    var moreButtonTapHandler: (() -> Void)?
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        setLayout()
        
        profileImageView.layer.cornerRadius = 12
        moreButton.addTarget(
            self,
            action: #selector(didTapMoreButton(_:)),
            for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Update
    func updateUI(comment: Comment, id: Int) {
        guard let url = URL(string: comment.profileImage) else { return }
        profileImageView.kf.setImage(with: url)
        nicknameLabel.text = comment.nickname
        contentLabel.text = comment.content
        dateLabel.text = formatDateForComments(comment.createdAt)
        wroteLabel.isHidden = comment.userID == id ? false : true
    }
    
    // MARK: - Actions
    @objc func didTapMoreButton(_ sender: UIButton) {
        moreButtonTapHandler?()
    }
    
    // MARK: - Setup
    func addViews() {
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
}
