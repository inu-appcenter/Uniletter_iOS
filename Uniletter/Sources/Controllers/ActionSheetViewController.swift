//
//  ActionSheetViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import UIKit
import PhotosUI

class ActionSheetViewController: UIViewController {

    let oneOptionActionSheetView = OneOptionActionSheetView()
    let twoOptionsActionSheetView = TwoOptionsActionSheetView()
    var actionSheet: ActionSheet?
    var option: Int?
    var myPageViewModel = MyPageViewModel.shared
    var selectPhotoCompletionClosure: (() -> Void)?
    var basicPhotoCompletionClosure: (() -> Void)?


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

    func setViewcontroller() {
        guard let option = option else {
            return
        }
        option == 1 ? setOneOptionActionSheetView() : setTwoOptionsActionSheetView()
    }
    
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
        case .topForUser: reportUser()
        case .topForWriter: modifyWriting()
        case .profile: blockUser()
        case .notification: notifyBeforeStart()
        case .commentForUser: reportUser()
        case .commentForWriter: deleteComment()
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
        case .notification: notifyBeforeEnd()
        case .commentForUser: blockUser()
        case .commentForWriter: break
        case .modifyInfo: basicPhoto()
        }
    }
    
    func reportUser() {
        // TODO: 유저 신고
    }
    
    func modifyWriting() {
        // TODO: 글 수정
    }
    
    func deleteWriting() {
        // TODO: 글 삭제
    }
    
    func blockUser() {
        // TODO: 유저 차단
    }
    
    func notifyBeforeStart() {
        // TODO: 시작 전 알림
    }
    
    func notifyBeforeEnd() {
        // TODO: 마감 전 알림
    }
    
    func deleteComment() {
        // TODO: 댓글 삭제
    }
    
    func selectPhoto() {

        self.dismiss(animated: true)
        
        if let selectPhotoCompletionClosure = selectPhotoCompletionClosure {
            selectPhotoCompletionClosure()
        }
    }
    
    func basicPhoto() {
        
        self.dismiss(animated: true)
        
        if let basicPhotoCompletionClosure = basicPhotoCompletionClosure {
            basicPhotoCompletionClosure()
        }
    }
}


