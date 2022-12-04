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
    
    lazy var ddayButton = DDayButton()
    
    lazy var infoStackView: InfoStackView = {
        let stackView = InfoStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var bodyTitleLabel: UILabel = {
        let label = UILabel()
        label.changeDetail("상세레터")
        
        return label
    }()
    
    lazy var bodyContentsTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.isScrollEnabled = false
        textView.isEditable = false
        
        return textView
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
        infoStackView.linkLabel.addGestureRecognizer(recognizeTapLink)
        
        [
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
    }
}
