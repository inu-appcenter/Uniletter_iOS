//
//  AlarmListCell.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import Foundation
import UIKit
import SwiftUI

class AlarmListCell: UICollectionViewCell {
    
    static let identifier = "AlarmListCell"
    
    let EventView = MyEventView(option: true)
    
    var alarmClosure: (() -> Void)?

    lazy var alarmButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "bell.fill")
        
        let button = UIButton(configuration: config)
        button.tintColor = UIColor.customColor(.yellow)
            
        button.addTarget(self, action: #selector(alarmButtonClicked(_:)), for: .touchUpInside)
        
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
        EventView.addSubview(alarmButton)
        
        EventView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview()
        }
        
        alarmButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(14)
            $0.height.equalTo(20)
        }
    }
    
    func setUI(event: Event) {
        guard let url = URL(string: event.imageURL) else { return }
        self.EventView.eventImage.kf.setImage(with: url)
        self.EventView.eventBodyLabel.text = event.body
        self.EventView.eventTitleLabel.text = event.title
        self.EventView.commentCountLabel.text = String(event.comments)
    }
    
    @objc func alarmButtonClicked(_ sender: UIGestureRecognizer) {
        if let alarmClosure = alarmClosure {
            alarmClosure()
        }
    }
}
