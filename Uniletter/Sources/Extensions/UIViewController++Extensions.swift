//
//  UIViewController++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit

extension UIViewController {
    // MARK: 알림 창, 액션 시트 통합
    func openAlert(title: String,
                   message: String,
                   alertStyle:UIAlertController.Style,
                   actionTitles:[String],
                   actionStyles:[UIAlertAction.Style],
                   actions: [((UIAlertAction) -> Void)]) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated()  {
            let action = UIAlertAction(
                title: indexTitle,
                style: actionStyles[index],
                handler: actions[index])
            alertController.addAction(action)
        }
        
        self.present(alertController, animated: true)
    }
    
    func goToLogin() {
        
    }
}
