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
    
    let EventView = MyEventView()
    
    var writeDayLabel: UILabel = {
        
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 13)
        
        label.textColor = UIColor.customColor(.lightGray)
        
        return label
    }()
    
    var separatorLine: UIView = {
        
        var view = UIView()
        
        view.backgroundColor = UIColor.customColor(.lightGray)
        
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateUI() {
        
        addSubview(EventView)
        [writeDayLabel, separatorLine] .forEach { EventView.addSubview($0)}
        
        EventView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        writeDayLabel.snp.makeConstraints {
            $0.top.equalTo(EventView).offset(28)
            $0.trailing.equalTo(EventView).offset(-20)
        }
        
        separatorLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.width.equalToSuperview()
        }
        
        EventView.eventImage.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(85)
            $0.height.equalTo(120)
        }
        
        EventView.eventTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(28)
            $0.leading.equalTo(EventView.eventImage.snp.trailing).inset(-20)
            $0.width.equalTo(175)
        }
        
        EventView.eventBodyLabel.snp.makeConstraints {
            $0.top.equalTo(EventView.eventTitleLabel.snp.bottom).inset(-4)
            $0.leading.equalTo(EventView.eventImage.snp.trailing).inset(-20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-44)
        }
        
        EventView.commentLabel.snp.makeConstraints {
            $0.bottom.equalTo(EventView.eventImage.snp.bottom)
            $0.leading.equalTo(EventView.eventImage.snp.trailing).inset(-20)
        }
    }
        
      
    func setUI(event: Event) {
        
        guard let url = URL(string: event.imageURL) else { return }
        self.EventView.eventImage.kf.setImage(with: url)
        self.EventView.eventBodyLabel.text = event.body
        self.EventView.eventTitleLabel.text = event.title
        self.writeDayLabel.text = caculateWriteDay(event.createdAt)
        self.EventView.commentCountLabel.text = String(event.comments)
    }
}
