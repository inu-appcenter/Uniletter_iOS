//
//  CommentsView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit
import SnapKit
import Then

final class CommentsView: BaseView {
    
    // MARK: - UI
    
    private lazy var arrowImageView = UIImageView().then {
        $0.image = UIImage(named: "arrowDown")
    }
    
    private lazy var border = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
    }
    
    lazy var writeView = UIView().then {
        $0.backgroundColor = .white
    }
    
    lazy var tableView = UITableView().then {
        $0.register(
            CommentsCell.self,
            forCellReuseIdentifier: CommentsCell.identifier)
        $0.estimatedRowHeight = 93
        $0.separatorColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        $0.separatorInset = .zero
    }
    
    lazy var commentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .customColor(.darkGray)
        $0.text = "댓글 0"
    }
    
    lazy var textField = UITextView().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .customColor(.lightGray)
        $0.sizeToFit()
        $0.text = "댓글을 입력해주세요."
        $0.isScrollEnabled = false
        $0.textContainerInset = .zero
    }
    
    lazy var submitButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .customColor(.lightGray)
        config.baseForegroundColor = .white
        
        var attributed = AttributedString("등록")
        attributed.font = .systemFont(ofSize: 16, weight: .semibold)
        config.attributedTitle = attributed
        
        $0.configuration = config
        $0.isUserInteractionEnabled = false
    }
    
    lazy var recognizeTapView = UITapGestureRecognizer().then {
        $0.numberOfTapsRequired = 1
        $0.numberOfTouchesRequired = 1
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureView() {
        tableView.addGestureRecognizer(recognizeTapView)
    }
    
    override func configureUI() {
        [border, textField, submitButton]
            .forEach { writeView.addSubview($0) }
        
        [
            commentLabel,
            arrowImageView,
            tableView,
            writeView,
        ]
            .forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        commentLabel.snp.makeConstraints {
            $0.top.left.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.centerY.equalTo(commentLabel)
            $0.left.equalTo(commentLabel.snp.right).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(border)
            $0.left.right.equalToSuperview()
        }
        
        writeView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.top).offset(-18)
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        border.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        textField.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(18)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(submitButton.snp.left).offset(-4)
            $0.height.lessThanOrEqualTo(80)
        }
        
        submitButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.right.equalToSuperview().offset(-20)
            $0.width.equalTo(58)
            $0.height.equalTo(35)
        }
    }
    
}
