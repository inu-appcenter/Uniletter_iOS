//
//  NoticeAlertView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit
import SnapKit
import Then

final class NoticeAlertView: BaseView {
       
    // MARK: - UI
    
    private lazy var backgroundView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.opacity = 0.4
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var alertView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    private lazy var separatorLine = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .customColor(.lightGray)
        $0.textAlignment = .center
    }
    
    lazy var bodyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    lazy var okButton = UIButton().then {
        $0.createCompletionButton("확인")
    }
    
    lazy var noButton = UIButton().then {
        $0.createCompletionButton("취소")
    }
    
    lazy var recognizeTapBackground = UITapGestureRecognizer()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureView() {
        backgroundColor = .clear
        backgroundView.addGestureRecognizer(recognizeTapBackground)
    }
    
    override func configureUI() {
        [backgroundView, alertView]
            .forEach { addSubview($0) }
        
        [titleLabel, bodyLabel]
            .forEach { alertView.addSubview($0) }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configureLayout() {
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
    
    // MARK: - Func
    
    private func updateOnlyOKButton() {
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
    
    private func updateOKAndCancelButtons() {
        [noButton, okButton]
            .forEach {
                alertView.addSubview($0)
                $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
            }
        
        noButton.backgroundColor = #colorLiteral(red: 0.8405835032, green: 0.9632034898, blue: 0.9564227462, alpha: 1)
        noButton.setTitleColor(.customColor(.blueGreen), for: .normal)
        
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
    }
    
    func setViewOptionCount(_ bool: Bool) {
        bool ? updateOKAndCancelButtons() : updateOnlyOKButton()
    }
    
    func setLabelParagraphStyle(_ bodyText: String?) {
        let attrString = NSMutableAttributedString(string: bodyText!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        attrString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: paragraphStyle,
            range: NSMakeRange(0, attrString.length))
        
        bodyLabel.attributedText = attrString
    }
}
