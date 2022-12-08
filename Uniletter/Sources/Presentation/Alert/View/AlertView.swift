//
//  AlertView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit
import SnapKit
import Then

final class AlertView: BaseView {
    
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
    
    lazy var alertLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    lazy var okButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitleColor(.customColor(.blueGreen), for: .normal)
    }
    
    lazy var cancleButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        $0.setTitleColor(.customColor(.lightGray), for: .normal)
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
        [alertLabel, okButton, cancleButton]
            .forEach { alertView.addSubview($0) }
        
        [backgroundView, alertView].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
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

