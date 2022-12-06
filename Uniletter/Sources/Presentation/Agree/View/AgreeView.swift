//
//  AgreeView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/10.
//

import UIKit
import SnapKit

class AgreementView: UIView {
    
    // MARK: - UI
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "*유니레터를 이용하려면 모든 약관에 동의해주셔야합니다."
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var allAgreeLabel = createAgreeLabel("모두 동의", true)
    
    lazy var allAgreeCheckButton = CheckButton()
    
    lazy var midBorderView = createGrayBorder()
    
    lazy var firstAgreeLabel = createAgreeLabel("이용 약관(필수)", false)
    
    lazy var firstMoreButton = createMoreButton()
    
    lazy var firstCheckButton = CheckButton()
    
    lazy var secondAgreeLabel = createAgreeLabel("개인정보 처리방침(필수)", false)
    
    lazy var secondMoreButton = createMoreButton()
    
    lazy var secondCheckButton = CheckButton()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("계속", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.cornerRadius = 4
        button.backgroundColor = .customColor(.blueGreen)
        
        return button
    }()
    
    // MARK: - Property
    
    var checkButtons = [UIButton]()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureLayout()
    }
    
    // MARK: - Setup
    
    func addViews() {
        [
            firstCheckButton,
            secondCheckButton,
        ]
            .forEach { checkButtons.append($0) }
        
        [
            guideLabel,
            allAgreeLabel,
            allAgreeCheckButton,
            midBorderView,
            firstAgreeLabel,
            firstMoreButton,
            firstCheckButton,
            secondAgreeLabel,
            secondMoreButton,
            secondCheckButton,
            nextButton
        ]
            .forEach { self.addSubview($0) }
    }
    
    func configureLayout() {
        allAgreeLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.leading.equalToSuperview().offset(20)
        }
        
        allAgreeCheckButton.snp.makeConstraints {
            $0.centerY.equalTo(allAgreeLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(16)
        }
        
        midBorderView.snp.makeConstraints {
            $0.top.equalTo(allAgreeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        firstAgreeLabel.snp.makeConstraints {
            $0.top.equalTo(midBorderView.snp.bottom).offset(20)
            $0.leading.equalTo(allAgreeLabel)
        }
        
        firstMoreButton.snp.makeConstraints {
            $0.top.equalTo(firstAgreeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(allAgreeLabel)
        }
        
        firstCheckButton.snp.makeConstraints {
            $0.centerY.equalTo(firstAgreeLabel)
            $0.trailing.equalTo(allAgreeCheckButton)
            $0.width.height.equalTo(16)
        }
        
        secondAgreeLabel.snp.makeConstraints {
            $0.top.equalTo(firstMoreButton.snp.bottom).offset(28)
            $0.leading.equalTo(allAgreeLabel)
        }
        
        secondMoreButton.snp.makeConstraints {
            $0.top.equalTo(secondAgreeLabel.snp.bottom).offset(4)
            $0.leading.equalTo(allAgreeLabel)
        }
        
        secondCheckButton.snp.makeConstraints {
            $0.centerY.equalTo(secondAgreeLabel)
            $0.trailing.equalTo(allAgreeCheckButton)
            $0.width.height.equalTo(16)
        }
        
        guideLabel.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Func
    
    private func createAgreeLabel(_ text: String, _ isAll: Bool) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = isAll
        ? .systemFont(ofSize: 18, weight: .bold)
        : .systemFont(ofSize: 16)
        
        return label
    }
    
    private func createMoreButton() -> UIButton {
        let button = UIButton()
        button.setTitle("더 알아보기", for: .normal)
        button.setTitleColor(UIColor.customColor(.blueGreen), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
        
        return button
    }
    
    private func createGrayBorder() -> UIView {
        let view = UIView()
        view.backgroundColor = .customColor(.borderGray)
        
        return view
    }
}
