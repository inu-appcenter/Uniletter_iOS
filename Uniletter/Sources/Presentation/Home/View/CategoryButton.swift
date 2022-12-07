//
//  CategoryButton.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/28.
//

import UIKit

final class CategoryButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    
    func configureButton(_ title: String) {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .trailing
        config.imagePadding = 5
        
        configuration = config
        layer.borderWidth = 1
        layer.borderColor = .customColor(.deepLightGray)
        
        changeState(title)
        clipsToBounds = true
        backgroundColor = .white
    }
    
    // MARK: - Func
    
    func changeState(_ title: String) {
        setAttributedTitle(
            title.changeCategoryAttributed(),
            for: .normal)
        sizeToFit()
    }
    
    func changeCornerRadius() {
        layer.cornerRadius = frame.height / 2
        layer.cornerCurve = .continuous
    }
    
}
