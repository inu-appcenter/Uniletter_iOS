//
//  UIViewController++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit
import SnapKit
import SwiftMessages
import Toast_Swift
import Then

extension UIViewController {
    
    // MARK: - Navigation
    
    func setNavigationTitleAndBackButton(_ title: String) {
        self.navigationItem.title = title
        self.navigationItem.hidesBackButton = true
        let config = UIImage.SymbolConfiguration(
            pointSize: 18,
            weight: .semibold)
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left", withConfiguration: config)?
                .withTintColor(.black, renderingMode: .alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(popViewController))
        
        self.navigationItem.leftBarButtonItems = [spacingItem(3), backButton]
    }
    
    @objc private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addNavigationBarBorder() {
        let navigationBarLayer = self.navigationController?.navigationBar.layer
        navigationBarLayer?.shadowColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
        navigationBarLayer?.shadowOpacity = 0.6
        navigationBarLayer?.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    // MARK: - Change Screen
    
    func goToInitialViewController() {
        let homeViewController = UINavigationController(
            rootViewController: HomeViewController())
        view.window?.rootViewController = homeViewController
        view.window?.rootViewController?.dismiss(animated: false)
    }
    
    // Present modal 통합
    func setModalStyle() {
        self.modalTransitionStyle = .crossDissolve
        self.modalPresentationStyle = .overFullScreen
    }
    
    // MARK: - Alert
    
    func presentLoginAlert(_ warning: Warning) {
        let vc = AlertVC(.login)
        vc.cancleButtonClosure = {
            self.presentWaringView(warning)
        }
        
        present(vc, animated: true)
    }
    
    func presentAlertView(_ alert: Alert) {
        let alertViewController = AlertViewController()
        alertViewController.alert = alert
        alertViewController.setModalStyle()
        
        present(alertViewController, animated: true)
    }
    
    func AlertVC(_ alert: Alert) -> AlertViewController {
        let alertViewController = AlertViewController()
        alertViewController.alert = alert
        alertViewController.setModalStyle()
        
        return alertViewController
    }
    
    // 액션 시트 띄우는 부분에서 변수에 이 함수로 뷰컨 리턴 받고 데이터 추가해서 present
    func presentActionSheetView(_ actionSheet: ActionSheet) -> ActionSheetViewController {
        let actionSheetViewController = ActionSheetViewController()
        actionSheetViewController.actionSheet = actionSheet
        actionSheetViewController.setModalStyle()
        
        return actionSheetViewController
    }
    
    func presentNoticeAlertView(noticeAlert: NoticeAlert, check: Bool) {
        let noticeAlertViewController = NoticeAlertViewController()
        noticeAlertViewController.check = check
        noticeAlertViewController.noticeAlert = noticeAlert
        noticeAlertViewController.setModalStyle()
        
        present(noticeAlertViewController, animated: true)
    }
    
    func getNoticeAlertVC(noticeAlert: NoticeAlert, check: Bool) -> NoticeAlertViewController {
        let noticeAlertViewController = NoticeAlertViewController()
        noticeAlertViewController.check = check
        noticeAlertViewController.noticeAlert = noticeAlert
        noticeAlertViewController.setModalStyle()
        
        return noticeAlertViewController
    }
    
    func presentWaringView(_ type: Warning) {
        let toastVC = ToastViewController(type).then {
            $0.modalTransitionStyle = .crossDissolve
            $0.modalPresentationStyle = .overFullScreen
        }
        
        self.present(toastVC, animated: false)
    }
    
    // MARK: - Notification
    
    func postHomeReloadNotification() {
        NotificationCenter.default.post(
            name: Notification.Name("HomeReload"),
            object: nil)
    }
    
    func postLikeNotification(_ id: Int, _ like: Bool) {
        NotificationCenter.default.post(
            name: NSNotification.Name("like"),
            object: nil,
            userInfo: ["id": id, "like": like])
    }
    
    // MARK: - HyperLink
    
    func openURL(_ url: String) {
        guard let url = URL(string: url) else {
            return
        }
        UIApplication.shared.open(url)
    }
    
}
