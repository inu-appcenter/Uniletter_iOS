//
//  HomeCell.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import SnapKit
import Kingfisher

class HomeCell: UICollectionViewCell {
    
    static let identifier = "homeCell"
    
    let homeCellView = HomeCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        homeCellView.frame = contentView.frame
        contentView.addSubview(homeCellView)
        homeCellView.bookmark.addTarget(self, action: #selector(didTapBookmarkButton(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(_ event: Event) {
        homeCellView.title.text = event.title
        updateDDay(event.endAt)
        homeCellView.category.text = event.category
        
        let url = URL(string: event.imageURL)!
        homeCellView.poster.kf.setImage(with: url, options: [.cacheMemoryOnly])
    }
    
    func updateDDay(_ text: String) {
        let intDDay = Int(text) ?? 0
        let dday: String
        
        if intDDay < 0 {
            homeCellView.dday.configuration?.baseBackgroundColor = UIColor.customColor(.darkGray)
            dday = "마감"
        } else {
            homeCellView.dday.configuration?.baseBackgroundColor = UIColor.customColor(.blueGreen)
            dday = intDDay == 0 ? "D-day" : "D-\(intDDay)"
        }
        
        var attributedString = AttributedString(dday)
        attributedString.font = .systemFont(ofSize: 13)
        
        homeCellView.dday.configuration?.attributedTitle = attributedString
    }
    
    @objc func didTapBookmarkButton(_ sender: UIButton) {
        homeCellView.bookmark.isSelected = !homeCellView.bookmark.isSelected
        
        homeCellView.bookmark.tintColor = homeCellView.bookmark.isSelected
        ? UIColor.customColor(.yellow)
        : UIColor.customColor(.lightGray)
    }
}
