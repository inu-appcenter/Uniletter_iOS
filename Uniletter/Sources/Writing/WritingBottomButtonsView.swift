//
//  WritingBottomButtonsView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit

final class WritingBottomButtonsView: UIView {
    
    // MARK: - UI
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = #colorLiteral(red: 0.8405835032, green: 0.9632034898, blue: 0.9564227462, alpha: 1)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.customColor(.blueGreen), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        return button
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6
        button.backgroundColor = UIColor.customColor(.blueGreen)
        button.setTitle("확인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setLayout()
    }
    
    // MARK: - Setup
    func addViews() {
        [cancleButton, okButton].forEach { addSubview($0) }
    }
    
    func setLayout() {
        cancleButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.48)
        }
        
        okButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.right.equalToSuperview()
            $0.width.equalTo(cancleButton)
        }
    }
}

