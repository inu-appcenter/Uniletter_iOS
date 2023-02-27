//
//  AlertViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit

final class AlertViewController: BaseViewController {
    
    // MARK: - Property
    
    private let alertView = AlertView()
    var alert: Alert?
    var warning: Warning?
    var alertIsSaveClosure: (() -> Void)?
    var alertIsNotificationClosure: (() -> Void)?
    var alertIsBlockOnClosure: (() -> Void)?
    var alertIsBlockOffClosure: (() -> Void)?
    var alertIsWriteClosure: (() -> Void)?
    var alertIsDeleteClosure: (() -> Void)?
    var cancleButtonClosure: (() -> Void)?
    var alertIsLoadClosure: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        alertView.alertLabel.text = alert?.title
        
        alertView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController))
        alertView.cancleButton.addTarget(
            self,
            action: #selector(didTapCancle),
            for: .touchUpInside)
        alertView.okButton.addTarget(
            self,
            action: #selector(didTapOKButton),
            for: .touchUpInside)
    }
    
    // MARK: - Func
    
    private func alertIsLogin() {
        view.window?.rootViewController = LoginViewController()
        view.window?.rootViewController?.dismiss(animated: false)
    }
    
    private func alertIsLogOut() {
        LoginManager.shared.logout {
            self.goToInitialViewController()
        }
    }
    
    private func completeTask() {
        guard let alert = alert else {
            return
        }
        
        switch alert {
        case .login:
            alertIsLogin()
        case .logout:
            alertIsLogOut()
        case .report:
            // TODO: 신고
            break
        case .blockOn:
            alertIsBlockOnClosure?()
        case .blockOff:
            alertIsBlockOffClosure?()
        case .delete:
            alertIsDeleteClosure?()
        case .write:
            alertIsWriteClosure?()
        case .save:
            alertIsSaveClosure?()
        case .notification:
            alertIsNotificationClosure?()
        case .load:
            alertIsLoadClosure?()
        }
    }
    
    // MARK: - Action
    
    @objc private func dismissViewController() {
        self.dismiss(animated: true)
    }
    
    @objc private func didTapOKButton() {
        completeTask()
        self.dismiss(animated: true)
    }
    
    @objc private func didTapCancle() {
        cancleButtonClosure?()
        self.dismiss(animated: true)
    }
    
}
