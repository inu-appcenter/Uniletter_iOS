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
        guard let url = URL(string: "https://github.com/vhzkclq0705/Uniletter_iOS/blob/main/%EC%9D%B4%EC%9A%A9%EC%95%BD%EA%B4%80.md") else { return }
        
        UIApplication.shared.open(url)
    }
    
    @objc func didTapSecondMoreButton(_ sedner: Any) {
        guard let url = URL(string: "https://github.com/vhzkclq0705/Uniletter_iOS/blob/main/%EA%B0%9C%EC%9D%B8%EC%A0%95%EB%B3%B4%EC%B2%98%EB%A6%AC%EB%B0%A9%EC%B9%A8.md") else { return }
        
        UIApplication.shared.open(url)
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
