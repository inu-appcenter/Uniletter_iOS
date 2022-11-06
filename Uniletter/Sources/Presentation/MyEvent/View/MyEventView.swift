//
//  MyEventView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/14.
//

import UIKit
import SnapKit

class MyEventView: UIView {
    
    var option: Bool?
    
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

    init(option: Bool) {
        self.option = option
        super.init(frame: .zero)
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
        
        eventImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.equalTo(85)
            $0.height.equalTo(120)
        }
                
        eventTitleLabel.snp.makeConstraints {
            $0.width.equalTo(175)
            $0.height.equalTo(20)
        }
                
        eventBodyLabel.snp.makeConstraints {
            $0.top.equalTo(eventTitleLabel.snp.bottom).inset(-4)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-44)
        }

        commentLabel.snp.makeConstraints {
            $0.bottom.equalTo(eventImage.snp.bottom)
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.bottom.equalTo(eventImage.snp.bottom)
            $0.leading.equalTo(commentLabel.snp.trailing).inset(-4)
        }
        
        
        if option == false {
                        
            [writeDayLabel, separatorLine]
                .forEach { subView.addSubview($0) }
            
            writeDayLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(28)
                $0.trailing.equalToSuperview().offset(-20)
            }
            
            separatorLine.snp.makeConstraints {
                $0.bottom.equalToSuperview()
                $0.height.equalTo(1)
                $0.width.equalToSuperview()
            }
            
            eventImage.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(20)
            }
            
            eventTitleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(28)
                $0.leading.equalTo(eventImage.snp.trailing).inset(-20)
            }
            
            eventBodyLabel.snp.makeConstraints {
                $0.leading.equalTo(eventImage.snp.trailing).inset(-20)
            }
            
            commentLabel.snp.makeConstraints {
                $0.leading.equalTo(eventImage.snp.trailing).inset(-20)
            }
            
        } else {
            eventImage.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(12)
            }
            
            eventTitleLabel.snp.makeConstraints {
                $0.top.equalToSuperview().offset(12)
                $0.leading.equalTo(eventImage.snp.trailing).inset(-8)
            }
            
            eventBodyLabel.snp.makeConstraints {
                $0.leading.equalTo(eventTitleLabel)
            }
            
            commentLabel.snp.makeConstraints {
                $0.leading.equalTo(eventTitleLabel)
            }
        }
    }
}
