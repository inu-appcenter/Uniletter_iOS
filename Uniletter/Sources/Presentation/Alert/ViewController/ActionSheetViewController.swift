//
//  ActionSheetViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit
import PhotosUI

final class ActionSheetViewController: UIViewController {
    
    // MARK: - Property
    let oneOptionActionSheetView = OneOptionActionSheetView()
    let twoOptionsActionSheetView = TwoOptionsActionSheetView()
    var actionSheet: ActionSheet?
    var option: Int?
    var loginManager = LoginManager.shared
    var myPageViewModel = MyPageManager.shared
    var selectPhotoCompletionClosure: (() -> Void)?
    var basicPhotoCompletionClosure: (() -> Void)?
    var blockUserCompletionClousre: (() -> Void)?
    var notifyBeforeStartCompletionClosure: (() -> Void)?
    var notifyBeforeEndCompletionClosure: (() -> Void)?
    var reportEventCompletionClosure: (() -> Void)?
    var reportCommentCompletionClisure: (() -> Void)?
    var deleteCommentCompletionClosure: (() -> Void)?
    
    // 기능 별 필요한 Property
    var commentID: Int!
    var eventID: Int?
    var event: Event!
    var setFor: String!
    var targetUserID: Int?
    
    // MARK: - Life cycle
    override func loadView() {
        guard let actionSheet = actionSheet else {
            return
        }
        
        switch actionSheet {
        case .topForUser, .profile, .commentForWriter:
            view = oneOptionActionSheetView
            option = 1
        default:
            view = twoOptionsActionSheetView
            option = 2
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewcontroller()
    }
    
    // MARK: - Setup
    func setViewcontroller() {
        guard let option = option else {
            return
        }
        option == 1 ? setOneOptionActionSheetView() : setTwoOptionsActionSheetView()
    }
    
    // MARK: - Actions
    func setOneOptionActionSheetView() {
        oneOptionActionSheetView.titleLabel.text = actionSheet?.title
        oneOptionActionSheetView.firstButton.setTitle(actionSheet?.buttonText[0], for: .normal)
        
        oneOptionActionSheetView.cancleButton.addTarget(
            self,
            action: #selector(dismissViewController(_:)),
            for: .touchUpInside)
        oneOptionActionSheetView.firstButton.addTarget(
            self,
            action: #selector(didTapFirstButton(_:)),
            for: .touchUpInside)
        oneOptionActionSheetView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController(_:)))
    }
    
    func setTwoOptionsActionSheetView() {
        twoOptionsActionSheetView.titleLabel.text = actionSheet?.title
        twoOptionsActionSheetView.firstButton.setTitle(actionSheet?.buttonText[0], for: .normal)
        twoOptionsActionSheetView.secondButton.setTitle(actionSheet?.buttonText[1], for: .normal)
        
        twoOptionsActionSheetView.cancleButton.addTarget(
            self,
            action: #selector(dismissViewController(_:)),
            for: .touchUpInside)
        twoOptionsActionSheetView.firstButton.addTarget(
            self,
            action: #selector(didTapFirstButton(_:)),
            for: .touchUpInside)
        twoOptionsActionSheetView.secondButton.addTarget(
            self,
            action: #selector(didTapSecondButton(_:)),
            for: .touchUpInside)
        twoOptionsActionSheetView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController(_:)))
    }
    
    @objc func dismissViewController(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @objc func didTapFirstButton(_ sender: UIButton) {
        guard let actionSheet = actionSheet else {
            return
        }
        
        switch actionSheet {
        case .topForUser:
            if let id = eventID {
                reportEvent(id)
            } else {
                reportEventCompletionClosure?()
            }
        case .topForWriter: modifyWriting()
        case .profile: blockUserForEvent()
        case .notification: notifyBeforeStart(eventID!)
        case .commentForUser: reportUser()
        case .commentForWriter: deleteComment(commentID)
        case .modifyInfo: selectPhoto()
        }
    }
    
    @objc func didTapSecondButton(_ sender: UIButton) {
        guard let actionSheet = actionSheet else {
            return
        }
        
        switch actionSheet {
        case .topForUser: break
        case .topForWriter: deleteWriting()
        case .profile: break
        case .notification: notifyBeforeEnd(eventID!)
        case .commentForUser: blockUserForComment(targetUserID)
        case .commentForWriter: break
        case .modifyInfo: basicPhoto()
        }
    }
    
    func reportEvent(_ eventId: Int) {
        self.dismiss(animated: true)
        if loginManager.isLoggedIn {
            API.reportEvent(eventId: eventId) { [weak self] in
                self?.reportEventCompletionClosure?()
            }
        } else {
            reportEventCompletionClosure?()
        }
    }
    
    func reportUser() {
        self.dismiss(animated: true)
        if loginManager.isLoggedIn {
            // FIXME: 댓글 신고 API 업데이트되면 변경 예정
            
            API.reportEvent(eventId: 0) { [weak self] in
                self?.reportCommentCompletionClisure?()
            }
        }
    }
    
    func modifyWriting() {
        let vc: UINavigationController = {
            let writingVC = WritingViewController()
            writingVC.event = self.event
            
            return UINavigationController(rootViewController: writingVC)
        }()
        
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true)
    }
    
    func deleteWriting() {
        API.deleteEvent(eventID!) { [weak self] in
            self?.goToInitialViewController()
        }
    }
    
    func blockUserForEvent() {
        self.dismiss(animated: true)
        blockUserCompletionClousre?()
    }
    
    func blockUserForComment(_ targetUserID: Int?) {
        if loginManager.isLoggedIn {
            API.postBlock(data: ["targetUserId": targetUserID!]) { [weak self] in
                NotificationCenter.default.post(
                    name: Notification.Name("reload"),
                    object: nil)
                self?.dismiss(animated: true)
            }
        } else {
            blockUserCompletionClousre?()
            self.dismiss(animated: true)
        }
    }
    
    func notifyBeforeStart(_ eventId: Int) {
        // TODO: 시작 전 알림
        
        API.postAlarm(["eventId": eventId, "setFor": "start"]) { [weak self] in
            self?.notifyBeforeStartCompletionClosure?()
            self?.dismiss(animated: true)
        }
    }
    
    func notifyBeforeEnd(_ eventId: Int) {
        // TODO: 마감 전 알림
        API.postAlarm(["eventId": eventId, "setFor": "end"]) { [weak self] in
            self?.notifyBeforeEndCompletionClosure?()
            self?.dismiss(animated: true)
        }
    }
    
    func deleteComment(_ commentID: Int) {
        API.deleteComment(commentID) { [weak self] in
            self?.postHomeReloadNotification()
            self?.deleteCommentCompletionClosure?()
            self?.dismiss(animated: true)
        }
    }
    
    func selectPhoto() {
        selectPhotoCompletionClosure?()
        self.dismiss(animated: true)
    }
    
    func basicPhoto() {
        basicPhotoCompletionClosure?()
        self.dismiss(animated: true)
    }
}


