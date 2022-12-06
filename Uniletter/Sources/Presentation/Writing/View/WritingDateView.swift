//
//  WritingDateView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/18.
//

import UIKit
import SnapKit
import Then

final class WritingDateView: BaseView {
    
    // MARK: - UI
    
    let titleLabel = UILabel()
    
    lazy var dateButton = createButton()
    
    lazy var timeButton = createButton()
    
    private let bar = UIView().then {
        $0.backgroundColor = .customColor(.defaultGray)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureUI() {
        [
            titleLabel,
            dateButton,
            bar,
            timeButton
        ]
            .forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.height.equalTo(23)
        }
        
        dateButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
            $0.left.equalToSuperview()
            $0.right.equalTo(bar.snp.left).offset(-4)
            $0.height.equalTo(44)
        }
        
        bar.snp.makeConstraints {
            $0.centerY.equalTo(dateButton)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(8)
            $0.height.equalTo(1)
        }
        
        timeButton.snp.makeConstraints {
            $0.top.bottom.height.equalTo(dateButton)
            $0.left.equalTo(bar.snp.right).offset(4)
            $0.right.equalToSuperview()
        }
    }
    
    // MARK: - Func
    
    private func createButton() -> UIButton {
        return UIButton().then {
            $0.layer.cornerRadius = 4
            $0.layer.borderWidth = 1
            $0.layer.borderColor = .customColor(.defaultGray)
        }
    }
    
}
