//
//  SaveListCell.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/14.
//

import UIKit
import SnapKit

class SaveListCell: UICollectionViewCell {
    
    static let identifier = "SaveListCell"
    
    let EventView = MyEventView(option: true)
    
    var bookMarkClosure: (() -> Void)?
    
    lazy var bookMarkButton: BookmarkButton = {
        
        let button = BookmarkButton()
        
        button.addTarget(self, action: #selector(bookMarkButtonClicked(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        EventView.layer.shadowColor = UIColor.customColor(.lightGray).cgColor
        EventView.layer.masksToBounds = false
        EventView.layer.shadowRadius = 7
        EventView.layer.shadowOpacity = 0.4
        EventView.layer.cornerRadius = 8
       
        addSubview(EventView)
        EventView.addSubview(bookMarkButton)
        
        EventView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(14)
            $0.height.equalTo(20)
        }
    }
    
    func setUI(event: Event) {
        self.EventView.eventImage.fetchImage(event.imageURL, 85, 120)
        self.EventView.eventBodyLabel.text = event.body
        self.EventView.eventTitleLabel.text = event.title
        self.EventView.commentCountLabel.text = String(event.comments)
//
        if let isLike = event.likedByMe {
            if isLike {
                bookMarkButton.isSelected = true
            } else {
                bookMarkButton.isSelected = false
            }
        }
    }
    
    func updateBookMark() {
        if bookMarkButton.isSelected {
            bookMarkButton.isSelected = false
        } else {
            bookMarkButton.isSelected = true
        }
    }
    
    @objc func bookMarkButtonClicked(_ sender: UIGestureRecognizer) {
        
        if let bookMarkClosure = bookMarkClosure {
            bookMarkClosure()
        }
    }
}
