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
    
    private let scrollView = UIScrollView()
    
    private let contentView = UIView()
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.text = "사진등록"
    }
    
    private let defaultLabel = UILabel().then {
        $0.writingTitle("없음 선택 시 유니레터가 제공하는 이미지가\n등록됩니다.")
        $0.numberOfLines = 0
        $0.textColor = UIColor.customColor(.darkGray)
    }
    
    private let clearView = UIView()
    
    lazy var imageView = UIImageView().then {
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = CGColor.customColor(.lightGray)
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
            checkView,
            clearView,
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
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-20)
            $0.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.left.right.equalTo(titleLabel)
            $0.height.equalTo(imageView.snp.width).multipliedBy(sqrt(2))
        }
        
        defaultLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.left.equalTo(titleLabel)
        }
        
        checkView.snp.makeConstraints {
            $0.top.equalTo(defaultLabel)
            $0.right.equalTo(titleLabel)
        }
        
        clearView.snp.makeConstraints {
            $0.top.equalTo(defaultLabel.snp.bottom)
            $0.bottom.left.right.equalToSuperview()
        }
    }
}
