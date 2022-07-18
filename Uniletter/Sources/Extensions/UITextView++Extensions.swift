//
//  UITextView++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/18.
//

import UIKit

extension UITextView {
    func writingTextView() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor.customColor(.defaultGray)
        self.tintColor = UIColor.customColor(.blueGreen)
        self.font = .systemFont(ofSize: 16)
        self.isScrollEnabled = false
    }
}
