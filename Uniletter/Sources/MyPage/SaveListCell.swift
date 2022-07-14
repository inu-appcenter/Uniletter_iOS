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
    
    let EventView = MyEventView()

    let bookMarkButton: UIButton = {
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "bookmark.fill")
        
        let button = UIButton(configuration: config)
        
        button.tintColor = UIColor.customColor(.yellow)
        
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
        
        EventView.eventImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
        }
        
        EventView.eventTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalTo(EventView.eventImage.snp.trailing).inset(-8)
        }
        
        EventView.eventBodyLabel.snp.makeConstraints {
            $0.leading.equalTo(EventView.eventTitleLabel.snp.leading)
        }
        
        EventView.commentLabel.snp.makeConstraints {
            $0.leading.equalTo(EventView.eventTitleLabel.snp.leading)
        }
    }
    
    func setUI(event: Event) {
        guard let url = URL(string: event.imageURL) else { return }
        self.EventView.eventImage.kf.setImage(with: url)
        self.EventView.eventBodyLabel.text = event.body
        self.EventView.eventTitleLabel.text = event.title
        self.EventView.commentCountLabel.text = String(event.comments)
    }
}
