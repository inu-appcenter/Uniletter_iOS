//
//  AlertView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit
import SnapKit

class AlertView: UIView {
    
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
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(UIColor.customColor(.blueGreen), for: .normal)
        
        return button
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(UIColor.customColor(.lightGray), for: .normal)
        
        return button
    }()
    
    let recognizeTapBackground = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setLayout()
    }
    
    func addViews() {
        [alertLabel, okButton, cancleButton].forEach { alertView.addSubview($0) }
        
        [backgroundView, alertView].forEach { addSubview($0) }
        
        backgroundView.addGestureRecognizer(recognizeTapBackground)
    }
    
    func setLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(120)
        }
        
        alertLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16)
        }
        
        okButton.snp.makeConstraints {
            $0.bottom.right.equalToSuperview().inset(16)
            $0.width.equalTo(26)
            $0.height.equalTo(20)
        }
        
        cancleButton.snp.makeConstraints {
            $0.bottom.width.height.equalTo(okButton)
            $0.right.equalTo(okButton.snp.left).offset(-20)
        }
    }
}

