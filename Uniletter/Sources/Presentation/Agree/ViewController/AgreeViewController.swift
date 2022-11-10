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
        agreementView.allAgreeRadioButton.addTarget(
            self,
            action: #selector(didTapAllAgreeRadioButton(_:)),
            for: .touchUpInside)
        
        agreementView.firstMoreButton.addTarget(
            self,
            action: #selector(didTapFirstMoreButton(_:)),
            for: .touchUpInside)
        
        agreementView.secondMoreButton.addTarget(
            self,
            action: #selector(didTapSecondMoreButton(_:)),
            for: .touchUpInside)
        
        agreementView.radioButtons.forEach {
            $0.addTarget(self, action: #selector(didTapRadioButton(_:)), for: .touchUpInside)
        }
        
        agreementView.nextButton.addTarget(
            self,
            action: #selector(didTapNextButton(_:)),
            for: .touchUpInside)
    }
    
    // MARK: - Func
    
    func checkAllRadioButtonsAreSelected() -> Bool {
        var checkCount: Int = 0
        agreementView.radioButtons.forEach {
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
        ? UIColor.customColor(.blueGreen)
        : UIColor.customColor(.lightGray)
    }
    
    
    // MARK: - Action
    
    @objc func didTapFirstMoreButton(_ sender: Any) {
        let vc = PersonalViewController()
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
    
    @objc func didTapSecondMoreButton(_ sedner: Any) {
        let vc = TermsViewController()
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
    
    @objc func didTapRadioButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        agreementView.allAgreeRadioButton.isSelected = checkAllRadioButtonsAreSelected()
    }
    
    @objc func didTapAllAgreeRadioButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        agreementView.radioButtons.forEach {
            $0.isSelected = button.isSelected
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