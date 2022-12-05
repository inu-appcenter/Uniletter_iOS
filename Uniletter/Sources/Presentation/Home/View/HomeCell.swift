//
//  HomeCell.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class HomeCell: UICollectionViewCell {
    
    static let identifier = "homeCell"
    
    // MARK: - UI
    
    lazy var posterImageView = UIImageView().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderColor = .customColor(.lightGray)
        $0.layer.borderWidth = 1
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 2
    }
    
    lazy var ddayButton = DDayButton()
    
    lazy var categoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = UIColor.customColor(.darkGray)
    }
    
    lazy var bookmarkButton = BookmarkButton().then {
        $0.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
    }
    
    // MARK: - Property
    
    var bookmarkButtonTapHandler: (() -> Void)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configureUI() {
        [
            posterImageView,
            titleLabel,
            ddayButton,
            categoryLabel,
            bookmarkButton
        ]
            .forEach { addSubview($0) }
    }
    
    private func configureLayout() {
        posterImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(sqrt(2))
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(8)
            $0.left.right.equalToSuperview()
        }
        
        ddayButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(titleLabel)
            $0.height.equalTo(23)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(ddayButton)
            $0.left.equalTo(ddayButton.snp.right).offset(8)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top)
            $0.right.equalToSuperview().offset(-10)
            $0.width.equalTo(15)
            $0.height.equalTo(23)
        }
    }
    
    // MARK: - func
    
    func updateCell(_ event: Event) {
        if let liked = event.likedByMe {
            bookmarkButton.isSelected = liked
        }
        
        titleLabel.text = event.title
        categoryLabel.text = event.category
        ddayButton.updateDDay(event.endAt)
        
        guard let url = URL(string: event.imageURL) else { return }
        posterImageView.kf.setImage(with: url, options: [.cacheMemoryOnly])
    }
    
    // MARK: - Action
    
    @objc private func didTapBookmarkButton() {
        bookmarkButtonTapHandler?()
    }
}
