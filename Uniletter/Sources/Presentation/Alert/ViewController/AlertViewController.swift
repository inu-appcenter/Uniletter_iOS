//
//  AlertViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit

final class AlertViewController: UIViewController {
    
    // MARK: - Property
    let alertView = AlertView()
    var alert: Alert?
    var alertIsSaveClosure: (() -> Void)?
    var alertIsNotificationClosure: (() -> Void)?
    var alertIsBlockOffClosure: (() -> Void)?
    var alertIsBlockOnClosure: (() -> Void)?
    var cancleButtonClosure: (() -> Void)?
    var warning: Warning?
    
    // MARK: - Life cycle
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
    }
    
    // MARK: - Setup
    func setViewController() {
        alertView.alertLabel.text = alert?.title
        
        alertView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController(_:)))
        
        alertView.cancleButton.addTarget(
            self,
            action: #selector(didTapCancle(_:)),
            for: .touchUpInside)
        
        alertView.okButton.addTarget(
            self,
            action: #selector(didTapOKButton(_:)),
            for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func dismissViewController(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func didTapOKButton(_ sender: UIButton) {
        guard let alert = alert else {
            return
        }
        
        switch alert {
        case .login: alertIsLogin()
        case .logout: alertIsLogOut()
        case .report: alertIsReport()
        case .blockOn: alertIsBlockOn()
        case .blockOff: alertIsBlockOff()
        case .delete: alertIsDelete()
        case .save: alertIsSave()
        case .notification: alertIsNotification()
        }
    }
    @objc func didTapCancle(_ sender: Any) {

        dismiss(animated: true)

        if let cancleButtonClosure = cancleButtonClosure {
            cancleButtonClosure()
        }
    }
    
    func alertIsLogin() {
        view.window?.rootViewController = LoginViewController()
        view.window?.rootViewController?.dismiss(animated: false)
    }
    
    func alertIsLogOut() {
        LoginManager.shared.logout {
            self.goToInitialViewController()
        }
    }
    
    func alertIsReport() {
        // TODO: 신고
    }
    
    func alertIsBlockOn() {
    }
    
    func alertIsBlockOff() {
        
        self.dismiss(animated: true)

        if let alertIsBlockOffClosure = alertIsBlockOffClosure {
            alertIsBlockOffClosure()
        }
    }
    
    func alertIsDelete() {
        // TODO: 삭제
    }
    
    // 저장 취소
    func alertIsSave() {
        if let alertIsSaveClosure = alertIsSaveClosure {
            alertIsSaveClosure()
        }
    }
    
    // 알림 취소
    func alertIsNotification() {
        if let alertIsNotificationClosure = alertIsNotificationClosure {
            alertIsNotificationClosure()
        }
    }
}
