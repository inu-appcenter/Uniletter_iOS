//
//  OneOptionActionSheetView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit
import SnapKit

class OneOptionActionSheetView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.4
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8405835032, green: 0.9632034898, blue: 0.9564227462, alpha: 1)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.customColor(.blueGreen), for: .normal)
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    lazy var alertView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.lightGray)
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var firstButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        
        return button
    }()

    lazy var firstBorder: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.customColor(.lightGray)
        
        return view
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
        [
            titleLabel,
            firstBorder,
            firstButton,
        ]
            .forEach { alertView.addArrangedSubview($0) }
        
        [backgroundView, alertView, cancleButton].forEach { addSubview($0) }
        
        backgroundView.addGestureRecognizer(recognizeTapBackground)
    }
    
    func setLayout() {
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
        
        cancleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-60)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
}
