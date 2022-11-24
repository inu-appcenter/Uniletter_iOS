//
//  AgreeViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/10.
//

import UIKit

final class AgreementViewController: UIViewController {

    // MARK: - Property
    
    let agreementView = AgreementView()
    
    // MARK: - Life cycle
    
    override func loadView() {
        self.view = agreementView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    // MARK: - Setup
    
    func setViewController() {
        addNavigationBarBorder()
        title = "약관 동의"
        
        agreementView.allAgreeCheckButton.addTarget(
            self,
            action: #selector(didTapAllAgreeCheckButton(_:)),
            for: .touchUpInside)
        
        agreementView.firstMoreButton.addTarget(
            self,
            action: #selector(didTapFirstMoreButton(_:)),
            for: .touchUpInside)
        
        agreementView.secondMoreButton.addTarget(
            self,
            action: #selector(didTapSecondMoreButton(_:)),
            for: .touchUpInside)
        
        agreementView.checkButtons.forEach {
            $0.addTarget(
                self,
                action: #selector(didTapCheckButton(_:)),
                for: .touchUpInside)
        }
        
        agreementView.nextButton.addTarget(
            self,
            action: #selector(didTapNextButton(_:)),
            for: .touchUpInside)
    }
    
    // MARK: - Func
    
    func checkAllCheckButtonsAreSelected() -> Bool {
        var checkCount: Int = 0
        agreementView.checkButtons.forEach {
            if $0.isSelected {
                checkCount += 1
            }
        }
        
        if checkCount == 2 {
            changeState(true)
            return true
        } else {
            changeState(false)
            return false
        }
    }
    
    func changeState(_ bool: Bool) {
        agreementView.nextButton.isUserInteractionEnabled = bool
        agreementView.nextButton.backgroundColor = bool
        ? .customColor(.blueGreen)
        : .customColor(.lightGray)
    }
    
    
    // MARK: - Action
    
    @objc func didTapFirstMoreButton(_ sender: Any) {
        let vc = ServiceViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapSecondMoreButton(_ sedner: Any) {
        let vc = PrivacyPolicyViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapCheckButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        button.updateUI(button.isSelected)
        
        agreementView.allAgreeCheckButton.isSelected = checkAllCheckButtonsAreSelected()
        agreementView.allAgreeCheckButton.updateUI(checkAllCheckButtonsAreSelected())
    }
    
    @objc func didTapAllAgreeCheckButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        button.updateUI(button.isSelected)
        
        agreementView.checkButtons.forEach {
            $0.isSelected = button.isSelected
            $0.updateUI(button.isSelected)
        }
        
        changeState(button.isSelected)
    }
    
    @objc func didTapNextButton(_ sendar: Any) {
        UserDefaults.standard.set(true, forKey: "agree")
        
        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .fullScreen

        view.window?.rootViewController = navigationController
    }
    
}
