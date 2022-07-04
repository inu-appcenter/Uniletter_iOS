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
}
