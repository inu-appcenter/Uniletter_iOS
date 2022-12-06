//
//  EventDetailView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit
import MarqueeLabel
import SnapKit
import Then

final class EventDetailView: BaseView {
    
    // MARK: - UI
    
    lazy var scrollView = UIScrollView()
    
    lazy var contentView = UIView()
    
    lazy var profileImageView = UIImageView().then {
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }
    
    lazy var nicknameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }
    
    lazy var dateWroteLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .customColor(.lightGray)
    }
    
    lazy var moreButton = UIButton().then {
        $0.setImage(UIImage(named: "ellipsisSmall"), for: .normal)
        $0.tintColor = .black
    }
    
    lazy var mainImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    lazy var titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0
    }
    
    lazy var ddayButton = DDayButton()
    
    lazy var infoStackView = InfoStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var bodyTitleLabel = UILabel().then {
        $0.changeDetail("상세레터")
    }
    
    lazy var bodyContentsTextView = UITextView().then {
        $0.font = .systemFont(ofSize: 16)
        $0.isScrollEnabled = false
        $0.isEditable = false
    }
    
    lazy var eyeImageView = UIImageView().then {
        $0.tintColor = .customColor(.darkGray)
        $0.image = UIImage(systemName: "eye")
    }
    
    lazy var viewsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .customColor(.darkGray)
        $0.text = "0회"
    }
    
    lazy var likeAndCommentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .customColor(.darkGray)
        $0.text = "저장 0 ∙ 댓글 0개"
    }
    
    lazy var notificationButton = NotificationButton()
    
    lazy var commentsButton = UIButton().then {
        $0.backgroundColor = .clear
    }
    
    private lazy var intervalView1 = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593990445, alpha: 1)
    }
    
    private lazy var intervalView2 = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.9593991637, green: 0.9593990445, blue: 0.9593990445, alpha: 1)
    }
    
    lazy var recognizeTapLink = UITapGestureRecognizer()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureUI() {
        infoStackView.linkLabel.addGestureRecognizer(recognizeTapLink)
        
        [
            profileImageView,
            nicknameLabel,
            dateWroteLabel,
            moreButton,
            mainImageView,
            intervalView1,
            titleLabel,
            ddayButton,
            infoStackView,
            intervalView2,
            bodyTitleLabel,
            bodyContentsTextView,
            eyeImageView,
            viewsLabel,
            likeAndCommentsLabel,
            commentsButton,
        ]
            .forEach { contentView.addSubview($0) }
        
        scrollView.addSubview(contentView)
        
        [
            scrollView,
            notificationButton,
        ]
            .forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.top.left.right.equalTo(scrollView.contentLayoutGuide)
            $0.bottom.equalTo(scrollView.contentLayoutGuide).offset(-52)
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
        }
        
        intervalView1.snp.makeConstraints {
            $0.top.equalTo(mainImageView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(intervalView1.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(ddayButton.snp.left).offset(-10)
        }
        
        ddayButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(23)
        }
        ddayButton.setContentHuggingPriority(.required, for: .horizontal)
        ddayButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        intervalView2.snp.makeConstraints {
            $0.top.equalTo(infoStackView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(8)
        }
        
        bodyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(intervalView2.snp.bottom).offset(20)
            $0.left.equalToSuperview().offset(20)
        }
        
        bodyContentsTextView.snp.makeConstraints {
            $0.top.equalTo(bodyTitleLabel.snp.bottom).offset(25)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        eyeImageView.snp.makeConstraints {
            $0.top.equalTo(bodyContentsTextView.snp.bottom).offset(20)
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
        
        commentsButton.snp.makeConstraints {
            $0.top.bottom.right.equalTo(likeAndCommentsLabel)
            $0.left.equalTo(likeAndCommentsLabel.snp.centerX)
        }
    }
    
}
