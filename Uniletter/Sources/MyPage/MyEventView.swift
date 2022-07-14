//
//  MyEventView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/14.
//

import UIKit
import SnapKit

class MyEventView: UIView {
    
    var subView: UIView = {
        var view = UIView()
        return view
    }()
    
    var eventImage: UIImageView = {
        
        var imageView = UIImageView()
        
        imageView.image = UIImage(named: "Study")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.cornerRadius = 8
        imageView.layer.borderColor = UIColor.customColor(.lightGray).cgColor
        imageView.layer.borderWidth = 1
        
        return imageView
    }()
    
    var eventTitleLabel: UILabel = {
    
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    var eventBodyLabel: UILabel = {
        
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()

    var commentLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 13)
        
        label.text = "댓글"
        label.textColor = UIColor.customColor(.darkGray)
        
        return label
    }()
    
    var commentCountLabel: UILabel = {
        
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 13)
        
        label.textColor = UIColor.customColor(.darkGray)
        
        return label
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configurateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurateUI() {
        
        addSubview(subView)
        
        [
            eventImage,
            eventTitleLabel,
            eventBodyLabel,
            commentLabel,
            commentCountLabel,
        ]
            .forEach { subView.addSubview($0) }
    
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        

        
        commentCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(eventImage.snp.bottom)
            $0.leading.equalTo(commentLabel.snp.trailing).inset(-4)
        }
    }
}
