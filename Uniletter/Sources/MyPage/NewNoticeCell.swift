//
//  NewNoticeCell.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/04.
//

import UIKit
import SnapKit

class NewNoticeCell: UICollectionViewCell {
    
    static let identifier = "NewNoticeCell"
    
    var imageView: UIImageView = {
        
        var imageView = UIImageView()
                
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setting() {
            
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
