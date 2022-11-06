//
//  TimePickerView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit
import SnapKit

final class TimePickerView: UIView {
    
    // MARK: - UI
    let subView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.writingTitle("시작시간 선택")
        
        return label
    }()
    
    let pickerView = UIPickerView()
    
    let selectedView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0, green: 0.6468470693, blue: 0.6219382882, alpha: 1)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    lazy var cancleButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.customColor(.lightGray), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        return button
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(UIColor.customColor(.blueGreen), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        
        return button
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black.withAlphaComponent(0.3)
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
    
    func setLayout() {
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
