//
//  NoticeAlertViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit

class NoticeAlertViewController: UIViewController {
    let noticeAlertView = NoticeAlertView()
    var noticeAlert: NoticeAlert?
    
    override func loadView() {
        view = noticeAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    func setViewController() {
        noticeAlertView.titleLabel.text = noticeAlert?.title
        noticeAlertView.bodyLabel.text = noticeAlert?.body
        
        noticeAlertView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController(_:)))
        
        noticeAlertView.okButton.addTarget(
            self,
            action: #selector(dismissViewController(_:)),
            for: .touchUpInside)
    }
    
    @objc func dismissViewController(_ sender: Any) {
        dismiss(animated: true)
    }
}
