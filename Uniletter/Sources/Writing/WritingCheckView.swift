//
//  WritingCheckView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit

final class WritingCheckView: UIView {
    
    // MARK: - UI
    let label: UILabel = {
        let label = UILabel()
        label.writingDefault("없음")
        
        return label
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor.customColor(.blueGreen)
        button.backgroundColor = UIColor.customColor(.blueGreen)
        button.setImage(UIImage(named: "check"), for: .selected)
        button.isSelected = true
        
        return button
    }()
    
    // MARK: - Init
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
    
    // MARK: - Setup
    func addViews() {
        [label, checkButton].forEach { addSubview($0) }
    }
    
    func setLayout() {
        label.snp.makeConstraints {
            $0.top.bottom.left.equalToSuperview()
            $0.right.equalTo(checkButton.snp.left).offset(-4)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.width.height.equalTo(16)
        }
    }
}
