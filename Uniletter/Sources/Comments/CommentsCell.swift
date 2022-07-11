//
//  CommentsCell.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit
import Kingfisher

class CommentsCell: UITableViewCell {
    
    static let identifier = "commentsCell"
    
    // MARK: - Property
    let commentsCellView = CommentsCellView()
    var moreButtonTapHandler: (() -> Void)?
    
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        commentsCellView.frame = contentView.frame
        contentView.addSubview(commentsCellView)
        
        commentsCellView.moreButton.addTarget(
            self,
            action: #selector(didTapMoreButton(_:)),
            for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func updateUI(_ comment: Comment) {
        guard let url = URL(string: comment.profileImage) else { return }
        commentsCellView.profileImageView.kf.setImage(with: url)
        commentsCellView.nicknameLabel.text = comment.nickname
        commentsCellView.contentLabel.text = comment.content
        commentsCellView.dateLabel.text = formatDateForComments(comment.createdAt)
        
        if comment.wroteByMe != nil {
            commentsCellView.wroteLabel.isHidden = false
        }
    }
    
    // MARK: - Actions
    @objc func didTapMoreButton(_ sender: UIButton) {
        moreButtonTapHandler?()
    }
    
}
