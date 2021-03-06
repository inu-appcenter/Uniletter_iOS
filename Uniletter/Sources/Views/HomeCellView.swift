//
//  HomeCellView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import SnapKit

final class HomeCellView: UIView {
    
    // MARK: - UI
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.borderColor = CGColor.customColor(.lightGray)
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        
        return imageView
    }()

    lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.font = .systemFont(ofSize: 18)
        textView.textContainer.lineFragmentPadding = 0
        
        return textView
    }()
    
    /// 원 모양을 생성 동시에 하기 위해 버튼으로 구현
    lazy var ddayButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor.customColor(.blueGreen)
        config.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = config
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.darkGray)
        
        return label
    }()
    
    lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "bookmark"), for: .normal)
        button.setBackgroundImage(UIImage(named: "bookmarkFill"), for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    // MARK: - Init
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
    
    // MARK: - Setup
    func addViews() {
        [posterImageView, titleTextView, ddayButton, categoryLabel, bookmarkButton].forEach { addSubview($0) }
    }
    
    func setLayout() {
        posterImageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(sqrt(2))
        }
        
        titleTextView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        ddayButton.snp.makeConstraints {
            $0.top.equalTo(titleTextView.snp.bottom).offset(8)
            $0.left.equalTo(titleTextView)
            $0.height.equalTo(23)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.bottom.equalTo(ddayButton)
            $0.left.equalTo(ddayButton.snp.right).offset(8)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top)
            $0.right.equalToSuperview().offset(-10)
            $0.width.equalTo(15)
            $0.height.equalTo(23)
        }
    }
}
