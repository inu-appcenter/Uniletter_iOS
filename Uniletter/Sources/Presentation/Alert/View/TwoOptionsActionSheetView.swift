//
//  TwoOptionsActionSheetView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit
import SnapKit
import Then

final class TwoOptionsActionSheetView: BaseView {
    
    // MARK: - UI
    
    private lazy var backgroundView = UIView().then {
        $0.backgroundColor = .black
        $0.layer.opacity = 0.4
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var alertView = UIStackView().then {
        $0.axis = .vertical
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
    }
    
    private lazy var firstBorder = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.918249011, green: 0.9182489514, blue: 0.9182489514, alpha: 1)
    }
    
    private lazy var secondBorder = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.918249011, green: 0.9182489514, blue: 0.9182489514, alpha: 1)
    }
    
    lazy var cancleButton = UIButton().then {
        $0.backgroundColor = #colorLiteral(red: 0.8405835032, green: 0.9632034898, blue: 0.9564227462, alpha: 1)
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.customColor(.blueGreen), for: .normal)
        $0.layer.cornerRadius = 10
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .customColor(.lightGray)
        $0.textAlignment = .center
    }
    
    lazy var firstButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
    }
    
    lazy var secondButton = UIButton().then {
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.setTitleColor(.black, for: .normal)
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
        backgroundView.addGestureRecognizer(recognizeTapBackground)
    }
    
    override func configureUI() {
        [
            titleLabel,
            firstBorder,
            firstButton,
            secondBorder,
            secondButton,
        ]
            .forEach { alertView.addArrangedSubview($0) }
        
        [backgroundView, alertView, cancleButton]
            .forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints {
            $0.bottom.equalTo(cancleButton.snp.top).offset(-12)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(41)
        }
        
        firstBorder.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        firstButton.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        secondBorder.snp.makeConstraints {
            $0.height.equalTo(1)
        }
        
        secondButton.snp.makeConstraints {
            $0.height.equalTo(52)
        }
        
        cancleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-60)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
}
