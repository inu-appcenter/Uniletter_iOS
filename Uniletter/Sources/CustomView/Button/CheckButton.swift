//
//  CheckButton.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/06.
//

import UIKit

final class CheckButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func configureButton() {
        layer.cornerRadius = 2
        layer.borderWidth = 1
        layer.borderColor = .customColor(.blueGreen)
        backgroundColor = .customColor(.blueGreen)
        setImage(UIImage(), for: .normal)
        setImage(UIImage(named: "check"), for: .selected)
        isSelected = true
    }
}
