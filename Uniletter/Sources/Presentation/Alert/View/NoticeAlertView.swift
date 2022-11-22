//
//  NoticeAlertView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit
import SnapKit

final class NoticeAlertView: UIView {
       
    // MARK: - UI
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
        
        button.createCompletionButton("확인")
        
        return button
    }()
    
    lazy var noButton: UIButton = {
        let button = UIButton()
        
        button.createCompletionButton("취소")
        
        return button
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        
        return view
    }()
    
    let recognizeTapBackground = UITapGestureRecognizer()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func configureUI() {
        [backgroundView, alertView]
            .forEach { addSubview($0) }
        
        [titleLabel, bodyLabel]
            .forEach { alertView.addSubview($0) }
        
        backgroundView.addGestureRecognizer(recognizeTapBackground)
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        bodyLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(26)
            $0.centerX.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(16)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    func setViewOptionCount(_ bool: Bool) {
        if bool {
            
            [ noButton,
              okButton,
            ] .forEach { alertView.addSubview($0) }
            
            noButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            okButton.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            
            noButton.backgroundColor = #colorLiteral(red: 0.8405835032, green: 0.9632034898, blue: 0.9564227462, alpha: 1)
            noButton.setTitleColor(UIColor.customColor(.blueGreen), for: .normal)
            
            noButton.snp.makeConstraints {
                $0.top.equalTo(bodyLabel.snp.bottom).offset(26)
                $0.leading.equalTo(alertView).offset(16)
                $0.trailing.equalTo(alertView.snp.centerX)
                $0.height.equalTo(44)
            }
            
            okButton.snp.makeConstraints {
                $0.top.equalTo(bodyLabel.snp.bottom).offset(26)
                $0.leading.equalTo(alertView.snp.centerX)
                $0.trailing.equalTo(alertView).inset(16)
                $0.height.equalTo(44)
            }

            alertView.snp.makeConstraints {
                $0.bottom.equalTo(noButton.snp.bottom).inset(-16)
            }
            
        } else {
            
            alertView.addSubview(okButton)

            okButton.snp.makeConstraints {
                $0.top.equalTo(bodyLabel.snp.bottom).offset(26)
                $0.centerX.equalToSuperview()
                $0.leading.equalTo(alertView).offset(16)
                $0.height.equalTo(44)
            }
            
            alertView.snp.makeConstraints {
                $0.bottom.equalTo(okButton.snp.bottom).inset(-16)
            }
        }
    }
    
    func setLabelParagraphStyle(_ bodyText: String?) {
        let attrString = NSMutableAttributedString(string: bodyText!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        
        bodyLabel.attributedText = attrString
    }
}
