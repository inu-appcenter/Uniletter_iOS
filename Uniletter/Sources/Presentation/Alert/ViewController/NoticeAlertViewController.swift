//
//  NoticeAlertViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit

final class NoticeAlertViewController: UIViewController {
    let noticeAlertView = NoticeAlertView()
    var noticeAlert: NoticeAlert?
    var check: Bool = false
    var okButtonCompletionClosure: (() -> Void)?
    
    override func loadView() {
        view = noticeAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    func setViewController() {
        noticeAlertView.setViewOptionCount(check)
        noticeAlertView.titleLabel.text = noticeAlert?.title
        noticeAlertView.bodyLabel.text = noticeAlert?.body
        
        noticeAlertView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController(_:)))
        
        noticeAlertView.okButton.addTarget(
            self,
            action: #selector(okButtonClicked(_:)),
            for: .touchUpInside)
        
        noticeAlertView.noButton.addTarget(
            self,
            action: #selector(dismissViewController(_:)),
            for: .touchUpInside)
    }
    
    @objc func dismissViewController(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func okButtonClicked(_ sender: UIGestureRecognizer) {
        
        dismiss(animated: true)
        
        if let okButtonCompletionClosure = okButtonCompletionClosure {
            okButtonCompletionClosure()
        }
    }
}
