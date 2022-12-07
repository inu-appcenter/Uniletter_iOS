//
//  ActionSheetViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit
import Then

final class ActionSheetViewController: BaseViewController {
    
    // MARK: - Property
    
    private let oneOptionActionSheetView = OneOptionActionSheetView()
    private let twoOptionsActionSheetView = TwoOptionsActionSheetView()
    private var loginManager = LoginManager.shared
    private var myPageViewModel = MyPageManager.shared
    
    var actionSheet: ActionSheet!
    var option: Int!
    var commentID: Int!
    var eventID: Int?
    var event: Event!
    var setFor: String!
    var targetUserID: Int?
    
    var selectPhotoCompletionClosure: (() -> Void)?
    var basicPhotoCompletionClosure: (() -> Void)?
    var blockUserCompletionClousre: (() -> Void)?
    var notifyBeforeStartCompletionClosure: (() -> Void)?
    var notifyBeforeEndCompletionClosure: (() -> Void)?
    var reportEventCompletionClosure: (() -> Void)?
    var reportCommentCompletionClisure: (() -> Void)?
    var deleteCommentCompletionClosure: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func loadView() {
        configureView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure
    
    private func configureView() {
        switch actionSheet {
        case .topForUser, .profile, .commentForWriter:
            view = oneOptionActionSheetView
            option = 1
        default:
            view = twoOptionsActionSheetView
            option = 2
        }
    }
    
    override func configureViewController() {
        option == 1 ? configureOneOption() : configureTwoOptions()
    }
    
    private func configureOneOption() {
        oneOptionActionSheetView.titleLabel.text = actionSheet.title
        oneOptionActionSheetView.firstButton.setTitle(actionSheet.buttonText[0], for: .normal)
        
        oneOptionActionSheetView.cancleButton.addTarget(
            self,
            action: #selector(dismissViewController),
            for: .touchUpInside)
        oneOptionActionSheetView.firstButton.addTarget(
            self,
            action: #selector(didTapFirstButton),
            for: .touchUpInside)
        oneOptionActionSheetView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController))
    }
    
    private func configureTwoOptions() {
        twoOptionsActionSheetView.titleLabel.text = actionSheet.title
        twoOptionsActionSheetView.firstButton.setTitle(actionSheet.buttonText[0], for: .normal)
        twoOptionsActionSheetView.secondButton.setTitle(actionSheet.buttonText[1], for: .normal)
        
        twoOptionsActionSheetView.cancleButton.addTarget(
            self,
            action: #selector(dismissViewController),
            for: .touchUpInside)
        twoOptionsActionSheetView.firstButton.addTarget(
            self,
            action: #selector(didTapFirstButton),
            for: .touchUpInside)
        twoOptionsActionSheetView.secondButton.addTarget(
            self,
            action: #selector(didTapSecondButton),
            for: .touchUpInside)
        twoOptionsActionSheetView.recognizeTapBackground.addTarget(
            self,
            action: #selector(dismissViewController))
    }
    
    // MARK: - Func
    
    private func reportEvent(_ eventId: Int) {
        self.dismiss(animated: true)
        if loginManager.isLoggedIn {
            API.reportEvent(eventId: eventId) { [weak self] in
                self?.reportEventCompletionClosure?()
            }
        } else {
            reportEventCompletionClosure?()
        }
    }
    
    private func reportUser() {
        self.dismiss(animated: true)
        if loginManager.isLoggedIn {
            // FIXME: 댓글 신고 API 업데이트되면 변경 예정
            
            API.reportEvent(eventId: 0) { [weak self] in
                self?.reportCommentCompletionClisure?()
            }
        }
    }
    
    private func modifyWriting() {
        let vc = WritingViewController()
        vc.event = event
        let naviVC = UINavigationController(rootViewController: vc)
        naviVC.modalPresentationStyle = .fullScreen
        
        self.present(naviVC, animated: true)
    }
    
    private func deleteWriting() {
        API.deleteEvent(eventID!) { [weak self] in
            self?.goToInitialViewController()
        }
    }
    
    private func blockUserForEvent() {
        self.dismiss(animated: true)
        blockUserCompletionClousre?()
    }
    
    private func blockUserForComment(_ targetUserID: Int?) {
        if loginManager.isLoggedIn {
            API.postBlock(data: ["targetUserId": targetUserID!]) { [weak self] in
                NotificationCenter.default.post(
                    name: Notification.Name("reload"),
                    object: nil)
                self?.dismiss(animated: true)
            }
        } else {
            self.dismiss(animated: true)
            blockUserCompletionClousre?()
        }
    }
    
    private func notifyBeforeStart(_ eventId: Int) {
        API.postAlarm(["eventId": eventId, "setFor": "start"]) { [weak self] in
            self?.dismiss(animated: true)
            self?.notifyBeforeStartCompletionClosure?()
        }
    }
    
    private func notifyBeforeEnd(_ eventId: Int) {
        API.postAlarm(["eventId": eventId, "setFor": "end"]) { [weak self] in
            self?.dismiss(animated: true)
            self?.notifyBeforeEndCompletionClosure?()
        }
    }
    
    private func deleteComment(_ commentID: Int) {
        API.deleteComment(commentID) { [weak self] in
            self?.dismiss(animated: true)
//            self?.postHomeReloadNotification()
            self?.deleteCommentCompletionClosure?()
        }
    }
    
    private func selectPhoto() {
        self.dismiss(animated: true)
        selectPhotoCompletionClosure?()
    }
    
    private func basicPhoto() {
        self.dismiss(animated: true)
        basicPhotoCompletionClosure?()
    }
    
    // MARK: - Action
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
    
    @objc private func didTapFirstButton() {
        switch actionSheet {
        case .topForUser:
            if let id = eventID {
                reportEvent(id)
            } else {
                reportEventCompletionClosure?()
            }
        case .topForWriter:
            modifyWriting()
        case .profile:
            blockUserForEvent()
        case .notification:
            notifyBeforeStart(eventID!)
        case .commentForUser:
            reportUser()
        case .commentForWriter:
            deleteComment(commentID)
        case .modifyInfo:
            selectPhoto()
        case .none:
            break
        }
    }
    
    @objc private func didTapSecondButton() {
        switch actionSheet {
        case .topForUser, .profile, .commentForWriter, .none:
            break
        case .topForWriter:
            deleteWriting()
        case .notification:
            notifyBeforeEnd(eventID!)
        case .commentForUser:
            blockUserForComment(targetUserID)
        case .modifyInfo:
            basicPhoto()
        }
    }
    
}


