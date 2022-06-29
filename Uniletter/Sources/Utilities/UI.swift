//
//  UI.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit

func spacingItem(_ spacing: CGFloat) -> UIBarButtonItem {
    let item = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    item.width = spacing
    
    return item
}
