//
//  NoticeAlertView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit
import SnapKit

class NoticeAlertView: UIView {
    
    lazy var backgroundView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.4
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.lightGray)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        
        button.createNofiButton("확인")
        
        return button
    }()
    
    let recognizeTapBackground = UITapGestureRecognizer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [backgroundView, alertView]
            .forEach { addSubview($0) }
        
        [titleLabel, bodyLabel, okButton]
            .forEach { alertView.addSubview($0) }
        
        backgroundView.addGestureRecognizer(recognizeTapBackground)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(okButton.snp.bottom).inset(-16)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(bodyLabel.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(alertView).offset(16)
            $0.height.equalTo(44)
        }
    }
}
