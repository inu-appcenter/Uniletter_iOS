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
    
    var subView: UIView = {
        var view = UIView()
        
        return view
    }()
    
    var imageView: UIImageView = {
        
        var imageView = UIImageView()
                
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    var imagetitle: UILabel = {
        
        var label = UILabel()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setting()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setting() {
            
        subView.layer.cornerRadius = 8
        subView.layer.borderWidth = 1
        subView.layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(subView)
        
        [
            imageView,
            imagetitle
        ]
            .forEach { subView.addSubview($0) }
        
        subView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalTo(subView)
            $0.top.equalTo(subView).offset(12)
        }
        
        imagetitle.snp.makeConstraints {
            $0.bottom.equalTo(subView).offset(-12)
            $0.centerX.equalTo(subView)
        }
    }
    
    func cellSelected(_ seclected: Bool) {
        if seclected {
            subView.layer.borderColor = UIColor.customColor(.blueGreen).cgColor
            subView.layer.borderWidth = 2
        } else {
            subView.layer.borderColor = UIColor.lightGray.cgColor
            subView.layer.borderWidth = 1
        }
    }
}
