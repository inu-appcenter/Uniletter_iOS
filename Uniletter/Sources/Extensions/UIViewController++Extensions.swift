//
//  UIViewController++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit

extension UIViewController {
    /// parameter에 넣은 제목대로 네비게이션 바 왼쪽 커스텀
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
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func presentAlertView(_ alert: Alert) {
        let alertViewController = AlertViewController()
        alertViewController.alert = alert
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        
        present(alertViewController, animated: true)
    }
    
    func AlertVC(_ alert: Alert) -> AlertViewController {
        let alertViewController = AlertViewController()
        alertViewController.alert = alert
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        
        return alertViewController
    }
    
    // 액션 시트 띄우는 부분에서 변수에 이 함수로 뷰컨 리턴 받고 데이터 추가해서 present
    func presentActionSheetView(_ actionSheet: ActionSheet) -> ActionSheetViewController {
        let actionSheetViewController = ActionSheetViewController()
        actionSheetViewController.actionSheet = actionSheet
        actionSheetViewController.modalPresentationStyle = .overFullScreen
        actionSheetViewController.modalTransitionStyle = .crossDissolve
        
        return actionSheetViewController
    }
    
    func presentNoticeAlertView(_ noticeAlert: NoticeAlert) {
        let noticeAlertViewController = NoticeAlertViewController()
        noticeAlertViewController.noticeAlert = noticeAlert
        noticeAlertViewController.modalPresentationStyle = .overFullScreen
        noticeAlertViewController.modalTransitionStyle = .crossDissolve
        
        present(noticeAlertViewController, animated: true)
    }
}
