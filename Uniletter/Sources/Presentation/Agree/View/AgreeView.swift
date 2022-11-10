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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "약관 동의"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        
        return label
    }()
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "유니레터를 이용하려면 모든 약관에 동의해야합니다."
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textAlignment = .center

        
        return label
    }()
    
    lazy var allAgreeLabel = createAgreeLabel("모두 동의")
    
    lazy var allAgreeRadioButton = createRadioButton()
    
    lazy var midBorderView = createGrayBorder()
    
    lazy var firstAgreeLabel = createAgreeLabel("이용 약관(필수)")
    
    lazy var firstMoreButton = createMoreButton()
    
    lazy var firstRadioButton = createRadioButton()
    
    lazy var secondAgreeLabel = createAgreeLabel("개인정보 처리방침(필수)")
    
    lazy var secondMoreButton = createMoreButton()
    
    lazy var secondRadioButton = createRadioButton()
    
    lazy var bottomBorderView = createGrayBorder()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.customColor(.lightGray)
        button.setTitle("계속", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.layer.cornerRadius = 4
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    // MARK: - Property
    
    var moreButtons = [UIButton]()
    var radioButtons = [UIButton]()
    
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
            firstMoreButton,
            secondMoreButton,
        ]
            .forEach { moreButtons.append($0) }
        
        [
            firstRadioButton,
            secondRadioButton,
        ]
            .forEach { radioButtons.append($0) }
        
        [
            titleLabel,
            guideLabel,
            allAgreeLabel,
            allAgreeRadioButton,
            midBorderView,
            firstAgreeLabel,
            firstMoreButton,
            firstRadioButton,
            secondAgreeLabel,
            secondMoreButton,
            secondRadioButton,
            bottomBorderView,
            nextButton
        ]
            .forEach { self.addSubview($0) }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        guideLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        allAgreeLabel.snp.makeConstraints {
            $0.top.equalTo(guideLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
        }
        
        allAgreeRadioButton.snp.makeConstraints {
            $0.centerY.equalTo(allAgreeLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(30)
        }
        
        midBorderView.snp.makeConstraints {
            $0.top.equalTo(allAgreeLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        firstAgreeLabel.snp.makeConstraints {
            $0.top.equalTo(midBorderView.snp.bottom).offset(15)
            $0.leading.equalTo(allAgreeLabel)
        }
        
        firstMoreButton.snp.makeConstraints {
            $0.top.equalTo(firstAgreeLabel.snp.bottom)
            $0.leading.equalTo(allAgreeLabel)
        }
        
        firstRadioButton.snp.makeConstraints {
            $0.centerY.equalTo(firstAgreeLabel)
            $0.trailing.equalTo(allAgreeRadioButton)
            $0.width.height.equalTo(30)
        }
        
        secondAgreeLabel.snp.makeConstraints {
            $0.top.equalTo(firstMoreButton.snp.bottom).offset(25)
            $0.leading.equalTo(allAgreeLabel)
        }
        
        secondMoreButton.snp.makeConstraints {
            $0.top.equalTo(secondAgreeLabel.snp.bottom)
            $0.leading.equalTo(allAgreeLabel)
        }
        
        secondRadioButton.snp.makeConstraints {
            $0.centerY.equalTo(secondAgreeLabel)
            $0.trailing.equalTo(allAgreeRadioButton)
            $0.width.height.equalTo(30)
        }
        
        bottomBorderView.snp.makeConstraints {
            $0.bottom.equalTo(nextButton.snp.top).offset(-20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    // MARK: - Func
    
    private func createAgreeLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }
    
    private func createMoreButton() -> UIButton {
        let button = UIButton()
        button.setTitle("더 알아보기", for: .normal)
        button.setTitleColor(UIColor.customColor(.blueGreen), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        
        return button
    }
    
    private func createRadioButton() -> UIButton {
        let button = UIButton()
        button.setBackgroundImage(
            UIImage(systemName: "circle")?
                .withTintColor(.lightGray, renderingMode: .alwaysOriginal),
            for: .normal)
        button.setBackgroundImage(
            UIImage(systemName: "circle.fill")?
                .withTintColor(UIColor.customColor(.blueGreen), renderingMode: .alwaysOriginal),
            for: .selected)
        
        button.setImage(
            UIImage(systemName: "checkmark")?
                .withTintColor(.white, renderingMode: .alwaysOriginal),
            for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }
    
    private func createGrayBorder() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }
}
