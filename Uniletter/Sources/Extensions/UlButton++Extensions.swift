//
//  UIButton++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit

extension UIButton {
    
    func createCompletionButton(_ title: String) {
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
    
    // 글쓰기 화면 체크버튼 상태 변경
    func updateUI(_ isSelected: Bool) {
        if isSelected {
            self.backgroundColor = UIColor.customColor(.blueGreen)
            self.layer.borderColor = CGColor.customColor(.blueGreen)
        } else{
            self.backgroundColor = .white
            self.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
        }
    }
}
