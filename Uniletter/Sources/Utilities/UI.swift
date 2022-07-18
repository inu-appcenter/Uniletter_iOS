//
//  UI.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit

// 네비게이션 바 아이템 간격을 위한 아이템
func spacingItem(_ spacing: CGFloat) -> UIBarButtonItem {
    let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    item.width = spacing
    
    return item
}

// text 밑줄 긋기
func showUnderline(_ text: String) -> NSMutableAttributedString {
    let attributedString = NSMutableAttributedString(
        string: text,
        attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    
    attributedString.addAttribute(
        .font,
        value: UIFont.systemFont(ofSize: 16),
        range: NSRange(location: 0, length: text.count))
    
    return attributedString
}
