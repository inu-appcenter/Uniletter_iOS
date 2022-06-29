//
//  DetailLabel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit

class DetailContesntsLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
