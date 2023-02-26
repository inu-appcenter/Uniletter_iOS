//
//  LoadListTableViewCell.swift
//  Uniletter
//
//  Created by 임현규 on 2023/02/26.
//

import UIKit

class LoadListTableViewCell: UITableViewCell {

    // MARK: - identifier
    static let identifier = "LoadListTableViewCell"

    // MARK: - Properties
    var deleteButtonClosure: (() -> Void)?

    // MARK: - UI Component
    
    let dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
    }
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
    }
    
    lazy var deleteButton: UIButton = {
    
        var config = UIButton.Configuration.plain()
        
        var attribute = AttributedString.init("삭제하기")
        attribute.font = .systemFont(ofSize: 13)
        
        config.attributedTitle = attribute
        
        let button = UIButton(configuration: config)
        button.tintColor = UIColor.customColor(.blueGreen)
        
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.customColor(.blueGreen).cgColor
        button.layer.borderWidth = 1
        
        button.addTarget(self, action: #selector(deleteButtonClicked(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override func layoutSubviews() {
        configureUI()
    }
    
    @objc func deleteButtonClicked(_ sender: UIGestureRecognizer) {
        if let deleteButtonClosure = deleteButtonClosure {
            deleteButtonClosure()
        }
    }

    func configureUI() {
        [   dateLabel,
            titleLabel,
            deleteButton
        ]   .forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(deleteButton.snp.centerY).inset(10.5)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.leading.equalToSuperview().inset(20)
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(80)
            $0.height.equalTo(21)
        }
    }
    
    func updateUI(_ event: SavedEvent) {
        titleLabel.text = event.title
        dateLabel.text = event.saveDate
    }
}
