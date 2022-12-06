//
//  WritingCheckView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit
import Then

final class WritingCheckView: BaseView {
    
    // MARK: - UI
    
    lazy var label = UILabel().then {
        $0.text = "없음"
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .customColor(.defaultGray)
    }
    
    lazy var checkButton = CheckButton()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureUI() {
        [label, checkButton].forEach { addSubview($0) }
    }
    
    override func configureLayout() {
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
