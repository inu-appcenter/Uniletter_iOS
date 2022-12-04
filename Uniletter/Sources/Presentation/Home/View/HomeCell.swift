//
//  HomeCell.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import Kingfisher

class HomeCell: UICollectionViewCell {
    
    static let identifier = "homeCell"
    
    // MARK: - Property
    let homeCellView = HomeCellView()
    var bookmarkButtonTapHandler: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        homeCellView.frame = contentView.frame
        contentView.addSubview(homeCellView)
        homeCellView.bookmarkButton.addTarget(
            self,
            action: #selector(didTapBookmarkButton(_:)),
            for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    func setUI(_ event: Event) {
        if let liked = event.likedByMe {
            homeCellView.bookmarkButton.isSelected = liked
            homeCellView.bookmarkButton.tintColor = liked
            ? UIColor.customColor(.yellow)
            : UIColor.customColor(.lightGray)
        }
        
        homeCellView.titleLabel.text = event.title
        homeCellView.ddayButton.updateDDay(event.endAt)
        homeCellView.categoryLabel.text = event.category
        
        guard let url = URL(string: event.imageURL) else { return }
        homeCellView.posterImageView.kf.setImage(with: url, options: [.cacheMemoryOnly])
    }
    
    // MARK: - Actions
    @objc func didTapBookmarkButton(_ sender: UIButton) {
        bookmarkButtonTapHandler?()
    }
}
