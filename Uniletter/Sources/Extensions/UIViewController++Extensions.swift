//
//  UIViewController++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit

extension UIViewController {
    func presentAlertView(_ alert: Alert) {
        let alertViewController = AlertViewController()
        alertViewController.alert = alert
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.modalTransitionStyle = .crossDissolve
        
        present(alertViewController, animated: true)
    }
}
