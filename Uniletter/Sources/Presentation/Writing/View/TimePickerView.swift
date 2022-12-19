//
//  TimePickerView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit
import SnapKit
import Then

final class TimePickerView: BaseView {
    
    // MARK: - UI
    
    private lazy var subView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    
    private lazy var selectedView = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0, green: 0.6468470693, blue: 0.6219382882, alpha: 1)
        $0.layer.cornerRadius = 10
    }
    
    lazy var pickerView = UIPickerView()
    
    lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
    }
    
    lazy var cancleButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(.customColor(.lightGray), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    lazy var okButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.customColor(.blueGreen), for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure

    override func configureView() {
        backgroundColor = .black.withAlphaComponent(0.3)
    }
    
    override func configureUI() {
        [
            titleLabel,
            selectedView,
            pickerView,
            cancleButton,
            okButton,
        ]
            .forEach { subView.addSubview($0) }
        
        addSubview(subView)
    }
    
    override func configureLayout() {
        subView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(298)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalToSuperview().offset(20)
        }
        
        pickerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().inset(25)
            $0.height.equalTo(150)
        }
        
        selectedView.snp.makeConstraints {
            $0.centerY.equalTo(pickerView)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.equalTo(42)
        }
        
        cancleButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-16)
            $0.right.equalTo(okButton.snp.left).offset(-20)
        }
        
        okButton.snp.makeConstraints {
            $0.centerY.equalTo(cancleButton)
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
}
