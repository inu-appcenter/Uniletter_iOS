//
//  WritingBottomButtonsView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit
import Then

final class WritingBottomButtonsView: BaseView {
    
    // MARK: - UI
    
    lazy var okButton = createButton(true)
    
    lazy var cancleButton = createButton(false)
    
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
    }
    
    override func configureUI() {
        [cancleButton, okButton].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
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
    
    // MARK: - Func
    
    private func createButton(_ isOK: Bool) -> UIButton {
        return UIButton().then {
            $0.layer.cornerRadius = 6
            $0.backgroundColor = isOK ? .customColor(.blueGreen) : #colorLiteral(red: 0.8405835032, green: 0.9632034898, blue: 0.9564227462, alpha: 1)
            $0.setTitle(isOK ? "확인" : "취소", for: .normal)
            $0.setTitleColor(isOK ? .white : .customColor(.blueGreen), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14)
        }
    }
    
}

