//
//  WritingPictureView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit
import Then

final class WritingPictureView: BaseView {
    
    // MARK: - UI
    
    private lazy var scrollView = UIScrollView()
    
    private lazy var contentView = UIView()
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.text = "사진등록"
    }
    
    private lazy var defaultLabel = UILabel().then {
        $0.text = "없음 선택 시 유니레터가 제공하는 이미지가\n등록됩니다."
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 0
        $0.textColor = .customColor(.darkGray)
    }
    
    lazy var imageView = UIImageView().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = .customColor(.lightGray)
        $0.image = UIImage(named: "defaultImage")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }
    
    lazy var checkView = WritingCheckView()
    
    lazy var recognizeTapImageView = UITapGestureRecognizer()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure

    override func configureView() {
        imageView.addGestureRecognizer(recognizeTapImageView)
    }
    
    override func configureUI() {
        [
            titleLabel,
            imageView,
            defaultLabel,
            checkView
        ]
            .forEach { contentView.addSubview($0) }
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalTo(scrollView.frameLayoutGuide)
            $0.top.left.right.equalTo(scrollView.contentLayoutGuide)
            $0.bottom.equalTo(scrollView.contentLayoutGuide).offset(-52)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.equalToSuperview().offset(20)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(imageView.snp.width).multipliedBy(sqrt(2))
        }
        
        defaultLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.bottom.left.equalToSuperview().inset(20)
        }
        
        checkView.snp.makeConstraints {
            $0.top.equalTo(defaultLabel)
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
}
