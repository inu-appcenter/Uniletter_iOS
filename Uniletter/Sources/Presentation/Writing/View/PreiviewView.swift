//
//  PreiviewView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/23.
//

import UIKit
import MarqueeLabel
import SnapKit

final class PreviewView: UIView {
    
    // MARK: - UI
    lazy var scrollView = UIScrollView()
    
    lazy var contentView = UIView()
    
    lazy var mainImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = WritingManager.shared.mainImage
        
        return imgView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        
        return label
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
        label.changeDetail("상세레터")
        
        return label
    }()
    
    lazy var bodyContentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        
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
        label.text = "0회"
        
        return label
    }()
    
    lazy var likeAndCommentsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.customColor(.darkGray)
        label.text = "저장 0 ∙ 댓글 0개"
        
        return label
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
    
    lazy var commentsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        
        return button
    }()
    
    let recognizeTapLink = UITapGestureRecognizer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addViews()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func addViews() {
        linkContentsLabel.addGestureRecognizer(recognizeTapLink)
        
        [
            mainImageView,
            intervalView1,
            titleLabel,
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
            commentsButton,
        ]
            .forEach { contentView.addSubview($0) }
        
        scrollView.addSubview(contentView)
        
        addSubview(scrollView)
    }
    
    func setLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.edges.equalTo(scrollView.contentLayoutGuide)
        }
        
        mainImageView.updateImageViewRatio(false)
        
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
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
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
        
        commentsButton.snp.makeConstraints {
            $0.top.bottom.right.equalTo(likeAndCommentsLabel)
            $0.left.equalTo(likeAndCommentsLabel.snp.centerX)
        }
        
        targetLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        contactLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        linkLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
}
