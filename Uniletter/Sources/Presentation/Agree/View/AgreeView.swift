//
//  AgreeView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/10.
//

import UIKit
import SnapKit
import Then

final class AgreementView: BaseView {
    
    // MARK: - UI
    
    private lazy var guideLabel = UILabel().then {
        $0.text = "*유니레터를 이용하려면 모든 약관에 동의해주셔야합니다."
        $0.textColor = .darkGray
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    private lazy var allAgreeLabel = createAgreeLabel("모두 동의", true)
    
    lazy var allAgreeCheckButton = CheckButton()
    
    private lazy var midBorderView = createGrayBorder()
    
    private lazy var firstAgreeLabel = createAgreeLabel("이용 약관(필수)", false)
    
    lazy var firstMoreButton = createMoreButton()
    
    lazy var firstCheckButton = CheckButton()
    
    private lazy var secondAgreeLabel = createAgreeLabel("개인정보 처리방침(필수)", false)
    
    lazy var secondMoreButton = createMoreButton()
    
    lazy var secondCheckButton = CheckButton()
    
    lazy var nextButton = UIButton().then {
        $0.setTitle("계속", for: .normal)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .customColor(.blueGreen)
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
    
    override func configureLayout() {
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
        return UILabel().then {
            $0.text = text
            $0.font = isAll ? .systemFont(ofSize: 18, weight: .bold) : .systemFont(ofSize: 16)
        }
    }
    
    private func createMoreButton() -> UIButton {
        return UIButton().then {
            $0.setTitle("더 알아보기", for: .normal)
            $0.setTitleColor(.customColor(.blueGreen), for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 11, weight: .bold)
        }
    }
    
    private func createGrayBorder() -> UIView {
        return UIView().then {
            $0.backgroundColor = .customColor(.borderGray)
        }
    }
    
}
