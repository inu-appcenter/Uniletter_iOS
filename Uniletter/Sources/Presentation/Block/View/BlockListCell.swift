//
//  BlockListCell.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit
import SnapKit

class BlockListCell: UITableViewCell {
    
    static let identifier = "BlockListCell"
    
    var blockCancleButtonClosure: (() -> Void)?
    
    let userImage: UIImageView = {
       
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "UserImage")
        
        imageView.layer.cornerRadius = 12
        imageView.layer.borderColor = UIColor.customColor(.lightGray).cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    var userName: UILabel = {
        
        let label = UILabel()
        
        label.text = "test"
        
        return label
    }()
    
    lazy var blockCancleButton: UIButton = {
    
        var config = UIButton.Configuration.plain()
        
        var attribute = AttributedString.init("차단 해제")
        attribute.font = .systemFont(ofSize: 13)
        
        config.attributedTitle = attribute
        
        let button = UIButton(configuration: config)
        button.tintColor = UIColor.customColor(.blueGreen)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.customColor(.blueGreen).cgColor
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(blockCancleButtonClicked(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    override func layoutSubviews() {
        configureUI()
    }
    
    func configureUI() {
        [userImage, userName, blockCancleButton]
            .forEach { addSubview($0) }
        
        userImage.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(24)
        }
        
        userName.snp.makeConstraints {
            $0.leading.equalTo(userImage.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        blockCancleButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(21)
        }
    }
    
    func setUI(block: Block) {

        self.userImage.image = UIImage(named: "UserImage")
        self.userName.text = block.user.nickname
    }
    
    @objc func blockCancleButtonClicked(_ sender: UIGestureRecognizer) {
        if let blockCancleButtonClosure = blockCancleButtonClosure {
            blockCancleButtonClosure()
        }
    }
}
