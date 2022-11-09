//
//  MyPageSectionView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/06/30.
//

import UIKit
import SnapKit

class MyPageSectionView: UITableViewHeaderFooterView {
    
    static let identifier = "MyPageSectionView"
    
    var label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.darkGray)
        
        return label
    }()
    
    override func layoutSubviews() {
        setting()
    }
    
    func setting() {
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
    func updateUI(_ text: String) {
        self.label.text = text
    }
}
