//
//  EventDetailView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit
import MarqueeLabel
import SnapKit

class EventDetailView : UIView {
    
    lazy var scrollView = UIScrollView()
    
    lazy var profileImageView = UIImageView()
    
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
        button.setImage(UIImage(named: "ellipsisSmall"), for: .normal)
        button.tintColor = .black
        
        return button
    }()
    
    lazy var mainImageView = UIImageView()
    
    lazy var titleTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = false
        textView.font = .boldSystemFont(ofSize: 20)
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        
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
        label.changeDetail("카테고리")
        
        return label
    }()
    
    lazy var startLabel: UILabel = {
        let label = UILabel()
        label.changeDetail("시작일시")
        
        return label
    }()
    
    lazy var endLabel: UILabel = {
        let label = UILabel()
        label.changeDetail("마감일시")
        
        return label
    }()
    
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.changeDetail("모집대상")
        
        return label
    }()
    
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.changeDetail("문의사항")
        
        return label
    }()
    
    lazy var linkLabel: UILabel = {
        let label = UILabel()
        label.changeDetail("신청링크")
        
        return label
    }()
    
    lazy var categoryContentsLabel = DetailContesntsLabel()
    
    lazy var startContentsLabel = DetailContesntsLabel()
    
    lazy var endContentsLabel = DetailContesntsLabel()
    
    lazy var targetContentsLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.font = .systemFont(ofSize: 16)
        label.speed = .duration(20)
        
        return label
    }()
    
    lazy var contactContentsLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.font = .systemFont(ofSize: 16)
        label.speed = .duration(20)
        
        return label
    }()
    
    lazy var linkContentsLabel: MarqueeLabel = {
        let label = MarqueeLabel()
        label.font = .systemFont(ofSize: 16)
        label.speed = .duration(20)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    lazy var bodyTitleLabel: UILabel = {
        let label = UILabel()
        label.changeDetail("상세내용")
        
        return label
    }()
    
    lazy var bodyContentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 50
        
        return label
    }()
    
    lazy var eyeImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.tintColor = UIColor.customColor(.darkGray)
        imageview.image = UIImage(systemName: "eye")
        
        return imageview
    }()
    
    lazy var viewsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.darkGray)
        
        return label
    }()
    
    lazy var likeAndCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.darkGray)
        
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
    
    let recognizeTapLink = UITapGestureRecognizer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setLayout()
    }
    
    func addViews() {
        linkContentsLabel.addGestureRecognizer(recognizeTapLink)
        
        [
            profileImageView,
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
            eyeImageView,
            viewsLabel,
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
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.left.equalToSuperview().offset(20)
            $0.width.height.equalTo(32)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        dateWroteLabel.snp.makeConstraints {
            $0.bottom.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        moreButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
            $0.right.equalToSuperview().offset(-20)
        }
        
        mainImageView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(15)
            $0.left.right.equalToSuperview().inset(20)
            $0.width.equalTo(notificationButton)
            $0.height.equalTo(mainImageView.snp.width).multipliedBy(sqrt(2))
        }
        
        intervalView1.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        titleTextView.snp.makeConstraints {
            $0.top.equalTo(intervalView1.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(ddayButton.snp.left).offset(-10)
            $0.height.equalTo(60)
        }
        
        ddayButton.snp.makeConstraints {
            $0.top.equalTo(titleTextView)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(23)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(intervalView1.snp.bottom).offset(80)
            $0.left.equalToSuperview().offset(20)
        }
        
        categoryContentsLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel)
            $0.left.equalToSuperview().offset(100)
        }
        
        startLabel.snp.makeConstraints {
            $0.top.equalTo(categoryLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        startContentsLabel.snp.makeConstraints {
            $0.top.equalTo(startLabel)
            $0.left.equalTo(categoryContentsLabel)
        }
        
        endLabel.snp.makeConstraints {
            $0.top.equalTo(startLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        endContentsLabel.snp.makeConstraints {
            $0.top.equalTo(endLabel)
            $0.left.equalTo(categoryContentsLabel)
        }
        
        targetLabel.snp.makeConstraints {
            $0.top.equalTo(endLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        targetContentsLabel.snp.makeConstraints {
            $0.top.equalTo(targetLabel)
            $0.left.equalTo(categoryContentsLabel)
            $0.right.equalToSuperview().offset(-20)
        }
        
        contactLabel.snp.makeConstraints {
            $0.top.equalTo(targetLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        contactContentsLabel.snp.makeConstraints {
            $0.top.equalTo(contactLabel)
            $0.left.equalTo(categoryContentsLabel)
            $0.right.equalToSuperview().offset(-20)
        }
        
        linkLabel.snp.makeConstraints {
            $0.top.equalTo(contactLabel.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        linkContentsLabel.snp.makeConstraints {
            $0.top.equalTo(linkLabel)
            $0.left.equalTo(categoryContentsLabel)
            $0.right.equalToSuperview().offset(-20)
        }
        
        intervalView2.snp.makeConstraints {
            $0.top.equalTo(linkLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        bodyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(intervalView2.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        bodyContentsLabel.snp.makeConstraints {
            $0.top.equalTo(bodyTitleLabel.snp.bottom).offset(25)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        eyeImageView.snp.makeConstraints {
            $0.top.equalTo(bodyContentsLabel.snp.bottom).offset(20)
            $0.bottom.equalToSuperview().offset(-40)
            $0.left.equalToSuperview().offset(20)
            $0.width.equalTo(18)
            $0.height.equalTo(15)
        }
        
        viewsLabel.snp.makeConstraints {
            $0.centerY.equalTo(eyeImageView)
            $0.left.equalTo(eyeImageView.snp.right).offset(5)
        }
        
        likeAndCommentsLabel.snp.makeConstraints {
            $0.centerY.equalTo(eyeImageView)
            $0.right.equalToSuperview().offset(-20)
        }
        
        targetLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        contactLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        linkLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
