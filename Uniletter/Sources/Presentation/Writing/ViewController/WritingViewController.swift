//
//  WritingViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit
import Then
import CoreData

final class WritingViewController: BaseViewController {
    
    // MARK: - UI
    
    private lazy var bottomView = WritingBottomButtonsView().then {
        $0.cancleButton.addTarget(
            self,
            action: #selector(didTapCancelButton),
            for: .touchUpInside)
        $0.okButton.addTarget(
            self,
            action: #selector(didTapOKButton),
            for: .touchUpInside)
    }
    
    private lazy var containerView = UIView()
    
    // MARK: - Property
    
    private let pictureViewController = WritingPictureViewController()
    private let contentViewController = WritingContentViewController()
    private let detailViewController = WritingDetailViewController()
    private let previewController = PreviewViewController()
    private let writingManager = WritingManager.shared
    private var page = 0
    var event: Event?
    var isSaved: Bool? = false
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainerView()
    }
    
    // MARK: - Configure
    
    override func configureNavigationBar() {
        setNavigationTitleAndBackButton(event == nil ? "레터등록" : "레터수정")
        addNavigationBarBorder()
        self.navigationItem.leftBarButtonItems?[1].action = #selector(popViewcontroller)
        addSaveButton()
    }
    
    override func configureViewController() {
        view.backgroundColor = .white
        writingManager.removeData()
        
        if let event = self.event {
            print("글 수정 시작")
            writingManager.loadEvent(event)
        } else {
            print("글 작성 시작")
        }
    }
    
    private func configureContainerView() {
        [
            pictureViewController,
            contentViewController,
            detailViewController,
            previewController,
        ]
            .forEach { addChild($0) }
        
        [containerView, bottomView].forEach { view.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-16)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.changeViewController(self.pictureViewController)
        }
    }
    
    // MARK: - Func
    
    private func changeViewController(_ vc: UIViewController) {
        vc.willMove(toParent: self)
        containerView.addSubview(vc.view)
        vc.view.frame = containerView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
    }
    
    private func changePage(_ isBack: Bool) {
        if isBack {
            page -= 1
            page == 0 ? changeCancleButtonTitle(true) : changeCancleButtonTitle(false)
            changePreviewTitle(false)
        } else {
            page += 1
            if page == 3 {
                changeNextButtonTitle(true)
                changePreviewTitle(true)
            } else {
                changeNextButtonTitle(false)
            }
            changeCancleButtonTitle(false)
        }
    }
    
    private func changeCancleButtonTitle(_ bool: Bool) {
        bottomView.cancleButton.setTitle(bool ? "취소" : "이전", for: .normal)
    }
    
    private func changeNextButtonTitle(_ bool: Bool) {
        bottomView.okButton.setTitle(bool ? "완료" : "다음", for: .normal)
    }
    
    private func changePreviewTitle(_ bool: Bool) {
        if event == nil {
            self.title = bool ? "미리보기" : "레터등록"
        } else {
            self.title = bool ? "미리보기" : "레터수정"
        }
    }
    
    private func postValidationNotification() {
        NotificationCenter.default.post(
            name: Notification.Name("validation"),
            object: nil)
    }
    
    private func checkWrite() {
        let vc = AlertVC(.write)
        
        vc.alertIsWriteClosure = {
            self.completeWrite()
        }
        
        self.present(vc, animated: true)
    }
    
    private func completeWrite() {
        if event == nil {
            writingManager.createEvent {
                self.goToInitialViewController()
            }
        } else {
            writingManager.updateEvent {
                self.goToInitialViewController()
            }
        }
    }
    
    private func addSaveButton() {
        if isSaved! {
            let saveButton = UIButton().then {
                $0.setTitle("임시저장", for: .normal)
                $0.titleLabel?.font = .systemFont(ofSize: 14)
                $0.setTitleColor(.black, for: .normal)
                $0.tintColor = .black
            }
         
            let loadButton = UIButton().then {
                $0.setTitle("불러오기(\(writingManager.reloadCount))", for: .normal)
                $0.titleLabel?.font = .systemFont(ofSize: 14)
                $0.setTitleColor(.black, for: .normal)
                $0.tintColor = .black
            }

            loadButton.isHidden = writingManager.reloadCount > 0 ? false : true
                        
            saveButton.addTarget(
                self,
                action: #selector(didTapSaveButton),
                for: .touchUpInside)
            
            loadButton.addTarget(
                self, action: #selector(didTapLoadButton),
                for: .touchUpInside)
            
            let saveItem = UIBarButtonItem(customView: saveButton)
            let loadItem = UIBarButtonItem(customView: loadButton)
            
            self.navigationItem.rightBarButtonItems = [saveItem, loadItem]
        }
    }

    @objc private func popViewcontroller() {
        if event == nil {
            self.navigationController?.popViewController(animated: true)
        } else {
            containerView.removeFromSuperview()
            bottomView.removeFromSuperview()
            self.dismiss(animated: true)
        }
        
    }
    
    @objc private func didTapCancelButton() {
        switch page {
        case 0:
            popViewcontroller()
        case 1:
            contentViewController.view.removeFromSuperview()
            changeViewController(pictureViewController)
        case 2:
            detailViewController.view.removeFromSuperview()
            changeViewController(contentViewController)
        case 3:
            previewController.view.removeFromSuperview()
            changeViewController(detailViewController)
        default: break
        }
        
        changePage(true)
    }
    
    @objc private func didTapOKButton() {
        switch page {
        case 0:
            pictureViewController.view.removeFromSuperview()
            changeViewController(contentViewController)
            changePage(false)
        case 1:
            if writingManager.checkEventInfo() == .success {
                contentViewController.view.removeFromSuperview()
                changeViewController(detailViewController)
                changePage(false)
            } else {
                postValidationNotification()
            }
        case 2:
            detailViewController.view.removeFromSuperview()
            previewController.preview = writingManager.showPreview()
            changeViewController(previewController)
            changePage(false)
        case 3:
            checkWrite()
        default: break
        }
    }
    
    @objc private func didTapSaveButton() {
        
        let noticeVC = getNoticeAlertVC(noticeAlert: .saveEvent, check: false)
        
        present(noticeVC, animated: true)
        
        writingManager.saveEvent()
    }
    
    @objc private func didTapLoadButton() {
        let loadVC = LoadViewController()
        self.navigationController?.pushViewController(loadVC, animated: true)
        
        loadVC.loadEventCompletionClosure = {
            self.writingManager.loadEventFromSave($0)
            self.contentViewController.updateContentFromSave()
            self.pictureViewController.updateImageViewFromSave()
            self.detailViewController.updateDetailFromSave()
        }
    }
}
