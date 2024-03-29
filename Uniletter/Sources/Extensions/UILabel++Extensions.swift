//
//  UILabel++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/30.
//

import UIKit

extension UILabel {
    func changeDetail(_ text: String) {
        self.text = text
        self.font = .systemFont(ofSize: 16, weight: .semibold)
        self.textColor = UIColor.customColor(.lightGray)
    }
}
