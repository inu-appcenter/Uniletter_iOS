//
//  MyPageCell.swift
//  Uniletter
//
//  Created by 임현규 on 2022/06/30.
//

import UIKit
import SnapKit

class MyPageCell: UITableViewCell {
    
    static let identifier = "MyPageCell"
    
    lazy var label: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    func setting() {
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
    }
    
    func updateUI(at text: String) {
        self.label.text = text
    }
}
