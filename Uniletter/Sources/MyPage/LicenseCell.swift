//
//  LicenseCell.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/26.
//

import UIKit
import SnapKit

class LicenseCell: UITableViewCell {
    
    static let identifier = "LicenseCell"
    
    lazy var label: UILabel = {
        var label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(label)
        
        label.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
    }
}
