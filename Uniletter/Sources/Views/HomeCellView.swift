//
//  HomeCellView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import SnapKit

class HomeCellView: UIView {
    
    lazy var poster: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.borderColor = CGColor.customColor(.lightGray)
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        
        return imageView
    }()

    lazy var title: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.font = .systemFont(ofSize: 18)
        
        return textView
    }()
    
    lazy var dday: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor.customColor(.blueGreen)
        config.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = config
        
        return button
    }()
    
    lazy var category: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.darkGray)
        
        return label
    }()
    
    lazy var bookmark: UIButton = {
        var config = UIButton.Configuration.plain()
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 18)
        let button = UIButton()
        button.configuration = config
        button.tintColor = UIColor.customColor(.lightGray)
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setLayout()
    }
    
    func addViews() {
        [poster, title, dday, category, bookmark].forEach { addSubview($0) }
    }
    
    func setLayout() {
        poster.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(poster.snp.width).multipliedBy(sqrt(2))
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(poster.snp.bottom)
            $0.left.right.equalToSuperview().inset(5)
            $0.height.equalTo(50)
        }
        
        dday.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(8)
            $0.left.equalTo(title)
            $0.height.equalTo(23)
        }
        
        category.snp.makeConstraints {
            $0.top.bottom.equalTo(dday)
            $0.left.equalTo(dday.snp.right).offset(8)
        }
        
        bookmark.snp.makeConstraints {
            $0.top.equalTo(poster.snp.top).offset(2)
            $0.right.equalToSuperview().offset(-10)
            $0.width.equalTo(14)
            $0.height.equalTo(20)
        }
    }
}
