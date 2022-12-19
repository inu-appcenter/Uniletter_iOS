//
//  NoticeAlertViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit

final class NoticeAlertViewController: BaseViewController {
    
    // MARK: - Property
    
    private let noticeAlertView = NoticeAlertView()
    var noticeAlert: NoticeAlert?
    var check: Bool = false
    var okButtonCompletionClosure: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = noticeAlertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        noticeAlertView.setViewOptionCount(check)
        noticeAlertView.titleLabel.text = noticeAlert?.title
        noticeAlertView.setLabelParagraphStyle(noticeAlert?.body)
        
        noticeAlertView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController))
        
        noticeAlertView.okButton.addTarget(
            self,
            action: #selector(okButtonClicked),
            for: .touchUpInside)
        
        noticeAlertView.noButton.addTarget(
            self,
            action: #selector(dismissViewController),
            for: .touchUpInside)
    }
    
    // MARK: - Action
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc private func okButtonClicked() {
        dismiss(animated: true)
        okButtonCompletionClosure?()
    }
}
