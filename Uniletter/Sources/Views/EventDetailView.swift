//
//  EventDetailView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit
import SnapKit

class EventDetailView : UIView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    /// 원 모양을 생성 동시에 하기 위해 버튼으로 구현
    lazy var profileImage: UIButton = {
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = config
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    lazy var dateWroteLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = UIColor.customColor(.lightGray)
        
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.vertical.bubble.fill"), for: .normal)
        
        return button
    }()
    
    lazy var mainImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.font = .boldSystemFont(ofSize: 18)
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
    
    lazy var categoryLabel: DetailLabel = {
        let label = DetailLabel()
        label.text = "카테고리"
        
        return label
    }()
    
    lazy var startLabel: DetailLabel = {
        let label = DetailLabel()
        label.text = "시작일시"
        
        return label
    }()
    
    lazy var endLabel: DetailLabel = {
        let label = DetailLabel()
        label.text = "마감일시"
        
        return label
    }()
    
    lazy var targetLabel: DetailLabel = {
        let label = DetailLabel()
        label.text = "모집대상"
        
        return label
    }()
    
    lazy var contactLabel: DetailLabel = {
        let label = DetailLabel()
        label.text = "문의사항"
        
        return label
    }()
    
    lazy var linkLabel: DetailLabel = {
        let label = DetailLabel()
        label.text = "신청링크"
        
        return label
    }()
    
    lazy var categoryContentsLabel = DetailContesntsLabel()
    
    lazy var startContentsLabel = DetailContesntsLabel()
    
    lazy var endContentsLabel = DetailContesntsLabel()
    
    lazy var targetContentsLabel = DetailContesntsLabel()
    
    lazy var contactContentsLabel = DetailContesntsLabel()
    
    lazy var linkContentsLabel = DetailContesntsLabel()
    
    lazy var bodyTitleLabel = DetailLabel()
    
    lazy var bodyContentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 50
        
        return label
    }()
    
    /// 조회수 아이콘을 위해 버튼으로 구현
    lazy var hitsButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor.customColor(.lightGray)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    lazy var likeAndCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.lightGray)
        
        return label
    }()
    
    lazy var notificationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customColor(.blueGreen)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    lazy var intervalView1: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593990445, alpha: 1)
        
        return view
    }()
    
    lazy var intervalView2: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593990445, alpha: 1)
        
        return view
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
        [
            profileImage,
            nicknameLabel,
            dateWroteLabel,
            moreButton,
            mainImageView,
            intervalView1,
            titleTextView,
            ddayButton,
            categoryLabel,
            categoryContentsLabel,
            startLabel,
            startContentsLabel,
            endLabel,
            endContentsLabel,
            targetLabel,
            targetContentsLabel,
            contactLabel,
            contactContentsLabel,
            linkLabel,
            linkContentsLabel,
            intervalView2,
            bodyTitleLabel,
            bodyContentsLabel,
            hitsButton,
            likeAndCommentsLabel,
        ]
            .forEach { scrollView.addSubview($0) }
        
        [
            scrollView,
            notificationButton,
        ]
            .forEach { addSubview($0) }
    }
    
    func setLayout() {
        scrollView.snp.makeConstraints {
            $0.top.left.right.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalTo(notificationButton.snp.top)
        }
        
        notificationButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-15)
            $0.left.right.equalTo(safeAreaLayoutGuide)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.left.equalToSuperview()
            $0.width.height.equalTo(32)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage)
            $0.left.equalTo(profileImage.snp.right).offset(8)
        }
        
        dateWroteLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImage)
            $0.left.equalTo(profileImage.snp.right).offset(8)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(profileImage)
            $0.right.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(15)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(mainImageView.snp.width).multipliedBy(sqrt(2))
        }
        
        intervalView1.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        titleTextView.snp.makeConstraints {
            $0.top.equalTo(intervalView1.snp.bottom).offset(25)
            $0.left.equalToSuperview()
            $0.right.equalTo(ddayButton.snp.left).offset(-4)
            $0.height.equalTo(50)
        }
        
        ddayButton.snp.makeConstraints {
            $0.top.equalTo(titleTextView)
            $0.left.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleTextView.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        
        categoryContentsLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel)
            $0.left.equalTo(categoryLabel.snp.right).offset(20)
        }
        
        startLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        
        startContentsLabel.snp.makeConstraints {
            $0.top.equalTo(startLabel)
            $0.left.equalTo(startLabel.snp.right).offset(20)
        }
        
        endLabel.snp.makeConstraints {
            $0.top.equalTo(startLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        
        endContentsLabel.snp.makeConstraints {
            $0.top.equalTo(endLabel)
            $0.left.equalTo(endLabel.snp.right).offset(20)
        }
        
        targetLabel.snp.makeConstraints {
            $0.top.equalTo(endLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        
        targetContentsLabel.snp.makeConstraints {
            $0.top.equalTo(targetLabel)
            $0.left.equalTo(targetLabel.snp.right).offset(20)
        }
        
        contactLabel.snp.makeConstraints {
            $0.top.equalTo(targetLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        
        contactContentsLabel.snp.makeConstraints {
            $0.top.equalTo(contactLabel)
            $0.left.equalTo(contactLabel.snp.right).offset(20)
        }
        
        linkLabel.snp.makeConstraints {
            $0.top.equalTo(contactLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        
        linkContentsLabel.snp.makeConstraints {
            $0.top.equalTo(linkLabel)
            $0.left.equalTo(linkLabel.snp.right).offset(20)
        }
        
        intervalView2.snp.makeConstraints {
            $0.top.equalTo(linkLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        bodyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(intervalView2.snp.bottom).offset(20)
            $0.left.equalToSuperview()
        }
        
        bodyContentsLabel.snp.makeConstraints {
            $0.top.equalTo(bodyTitleLabel).offset(25)
            $0.left.right.equalToSuperview()
        }
        
        hitsButton.snp.makeConstraints {
            $0.top.equalTo(bodyContentsLabel).offset(20)
            $0.left.equalToSuperview()
        }
        
        likeAndCommentsLabel.snp.makeConstraints {
            $0.top.equalTo(bodyContentsLabel).offset(20)
            $0.right.equalToSuperview()
        }
    }
}
