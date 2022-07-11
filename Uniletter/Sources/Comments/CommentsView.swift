//
//  CommentsView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit
import SnapKit

class CommentsView: UIView {
    
    // MARK: - UI
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommentsCell.self, forCellReuseIdentifier: CommentsCell.identifier)
        tableView.estimatedRowHeight = 93
        tableView.isHidden = true
        
        return tableView
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.customColor(.darkGray)
        label.text = "댓글 0"
        
        return label
    }()
    
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowUp"), for: .normal)
        button.setImage(UIImage(named: "arrowDown"), for: .selected)
        
        return button
    }()
    
    let border: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.918249011, green: 0.9182489514, blue: 0.9182489514, alpha: 1)
        
        return view
    }()
    
    let writeView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var textField: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 16)
        textView.textColor = UIColor.customColor(.lightGray)
        textView.text = "댓글을 입력해주세요."
        textView.isScrollEnabled = false
        textView.textContainerInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0)
        
        return textView
    }()
    
    lazy var submitButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor.customColor(.lightGray)
        config.baseForegroundColor = .white
        
        var attributed = AttributedString("등록")
        attributed.font = .systemFont(ofSize: 16, weight: .semibold)
        config.attributedTitle = attributed
        
        let button = UIButton()
        button.configuration = config
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addviews()
    }
    
    override func layoutSubviews() {
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    func addviews() {
        [border, textField, submitButton]
            .forEach { writeView.addSubview($0) }
        
        [
            commentLabel,
            arrowButton,
            tableView,
            writeView,
        ]
            .forEach { addSubview($0) }
    }
    
    func setLayout() {
        commentLabel.snp.makeConstraints {
            $0.top.left.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        arrowButton.snp.makeConstraints {
            $0.centerY.equalTo(commentLabel)
            $0.left.equalTo(commentLabel.snp.right).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().offset(-100)
            $0.left.right.equalTo(safeAreaLayoutGuide)
        }
        
        writeView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.top).offset(-18)
            $0.bottom.left.right.equalTo(safeAreaLayoutGuide)
        }
        
        border.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        textField.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(18)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalTo(submitButton.snp.left).offset(-4)
        }
        
        submitButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(12)
            $0.right.equalToSuperview().offset(-20)
            $0.width.equalTo(58)
            $0.height.equalTo(35)
        }
    }
}
