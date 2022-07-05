//
//  AlertViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit

class AlertViewController: UIViewController {
    
    let alertView = AlertView()
    var alert: Alert?

    override func loadView() {
        view = alertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViewController()
    }
    
    func setViewController() {
        alertView.alertLabel.text = alert?.title
        
        alertView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController(_:)))
        
        alertView.cancleButton.addTarget(
            self,
            action: #selector(dismissViewController(_:)),
            for: .touchUpInside)
        
        alertView.okButton.addTarget(
            self,
            action: #selector(didTapOKButton(_:)),
            for: .touchUpInside)
    }
    
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
    
    func alertIsLogin() {
        view.window?.rootViewController = LoginViewController()
        view.window?.rootViewController?.dismiss(animated: false)
    }
    
    func alertIsLogOut() {
        let defaultInfo = LoginInfo(jwt: "", userID: 0, rememberMeToken: "")
        LoginManager.shared.saveLoginInfo(defaultInfo)
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        view.window?.rootViewController = homeViewController
        view.window?.rootViewController?.dismiss(animated: false)
    }
    
    func alertIsReport() {
        // TODO: 신고
    }
    
    func alertIsBlockOn() {
        // TODO: 차단
    }
    
    func alertIsBlockOff() {
        // TODO: 차단 해제
    }
    
    func alertIsDelete() {
        // TODO: 삭제
    }
    
    func alertIsSave() {
        // TODO: 저장 취소
    }
    
    func alertIsNotification() {
        // TODO: 알림 해제
    }
}
