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
