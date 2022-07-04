//
//  UIButton++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit

extension UIButton {
    
    func createNofiButton(_ title: String) {
        self.backgroundColor = UIColor.customColor(.blueGreen)
        self.tintColor = .white
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        self.layer.cornerRadius = 6
        self.setTitle(title, for: .normal)
    }
    
    func listButtonSetting(_ image: String, _ title: String) {
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.imagePadding = 10
        config.imagePlacement = .leading
        config.image = UIImage(systemName: image)
        
        self.configuration = config
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.setTitleColor(.black, for: .normal)
        self.tintColor = UIColor.customColor(.yellow)
        self.setTitle(title, for: .normal)
    }
}
