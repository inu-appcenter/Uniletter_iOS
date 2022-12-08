//
//  MyCommentCell.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/08.
//

import UIKit
import SnapKit
import Kingfisher

class MyEventCell: UICollectionViewCell {
    
    static let identifier = "MyEventCell"
    
    let EventView = MyEventView(option: false)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateUI() {
        
        addSubview(EventView)
        
        EventView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
        
      
    func setUI(event: Event) {
        
        guard let url = URL(string: event.imageURL) else { return }
        self.EventView.eventImage.kf.setImage(with: url)
        self.EventView.eventBodyLabel.text = event.body
        self.EventView.eventTitleLabel.text = event.title
        self.EventView.writeDayLabel.text = CustomFormatter.convertISO8601DateToString(
            event.createdAt,
            "MM/dd",
            true)
        self.EventView.commentCountLabel.text = String(event.comments)
    }
}
