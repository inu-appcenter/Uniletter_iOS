//
//  AgreeViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/10.
//

import UIKit

final class AgreementViewController: BaseViewController {

    // MARK: - Property
    
    private let agreementView = AgreementView()
    private lazy var checkButtons = [
        agreementView.firstCheckButton,
        agreementView.secondCheckButton
    ]
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = agreementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCheckButtons()
    }
    
    // MARK: - Configure
    
    override func configureNavigationBar() {
        title = "약관 동의"
        addNavigationBarBorder()
    }
    
    override func configureViewController() {
        agreementView.allAgreeCheckButton.addTarget(
            self,
            action: #selector(didTapAllAgreeCheckButton(_:)),
            for: .touchUpInside)
        
        agreementView.firstMoreButton.addTarget(
            self,
            action: #selector(didTapFirstMoreButton),
            for: .touchUpInside)
        agreementView.secondMoreButton.addTarget(
            self,
            action: #selector(didTapSecondMoreButton),
            for: .touchUpInside)
        agreementView.nextButton.addTarget(
            self,
            action: #selector(didTapNextButton),
            for: .touchUpInside)
    }
    
    private func configureCheckButtons() {
        checkButtons.forEach {
            $0.addTarget(
                self,
                action: #selector(didTapCheckButton(_:)),
                for: .touchUpInside)
        }
    }
    
    // MARK: - Func
    
    private func checkAllCheckButtonsAreSelected() -> Bool {
        var checkCount: Int = 0
        checkButtons.forEach {
            if $0.isSelected {
                checkCount += 1
            }
        }
        
        if checkCount == 2 {
            changeState(true)
            agreementView.allAgreeCheckButton.updateCheckedState()
            return true
        } else {
            changeState(false)
            agreementView.allAgreeCheckButton.updateNotCheckedState()
            return false
        }
    }
    
    private func changeState(_ bool: Bool) {
        agreementView.nextButton.isUserInteractionEnabled = bool
        agreementView.nextButton.backgroundColor = bool
        ? .customColor(.blueGreen)
        : .customColor(.lightGray)
    }
    
    // MARK: - Action
    
    @objc private func didTapFirstMoreButton() {
        let vc = ServiceViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapSecondMoreButton() {
        let vc = PrivacyPolicyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapCheckButton(_ sender: CheckButton) {
        sender.updateState()
        _ = checkAllCheckButtonsAreSelected()
    }
    
    @objc private func didTapAllAgreeCheckButton(_ sender: CheckButton) {
        sender.updateState()
        changeState(sender.isSelected)
        checkButtons.forEach {
            sender.isSelected ? $0.updateCheckedState() : $0.updateNotCheckedState()
        }
    }
    
    @objc private func didTapNextButton() {
        UserDefaults.standard.set(true, forKey: "agree")
        
        goToInitialViewController()
    }
    
}
