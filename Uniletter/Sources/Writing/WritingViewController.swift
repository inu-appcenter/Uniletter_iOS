//
//  WritingViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit

final class WritingViewController: UIViewController {
    
    // MARK: - UI
    lazy var bottomView: WritingBottomButtonsView = {
        let view = WritingBottomButtonsView()
        view.cancleButton.addTarget(
            self,
            action: #selector(didTapCancleButton(_:)),
            for: .touchUpInside)
        view.okButton.addTarget(
            self,
            action: #selector(didTapOKButton(_:)),
            for: .touchUpInside)
        
        return view
    }()
    
    let containerView = UIView()
    
    // MARK: - Property
    let pictureViewController = WritingPictureViewController()
    let contentViewController = WritingContentViewController()
    let detailViewController = WritingDetailViewController()
    let previewController = PreviewViewController()
    var updateID: Int?
    var page = 0
    let writingManager = WritingManager.shared
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setContainerView()
        setViewController()
    }
    
    // MARK: - Setup
    func setNavigationBar() {
        self.navigationItem.title = "레터등록"
        self.navigationItem.hidesBackButton = true
        let config = UIImage.SymbolConfiguration(
            pointSize: 18,
            weight: .semibold)
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left", withConfiguration: config)?
                .withTintColor(.black, renderingMode: .alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(didTapBackButton))
        
        self.navigationItem.leftBarButtonItems = [spacingItem(3), backButton]
    }
    
    func setViewController() {
        view.backgroundColor = .white
        changeViewController(pictureViewController)
    }
    
    func setContainerView() {
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
            $0.bottom.equalTo(bottomView.snp.top)
            $0.left.right.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints {
            $0.bottom.equalTo(view.keyboardLayoutGuide.snp.top).offset(-16)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Funcs
    func changeViewController(_ vc: UIViewController) {
        vc.willMove(toParent: self)
        containerView.addSubview(vc.view)
        vc.view.frame = containerView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
    }
    
    func changePage(_ isBack: Bool) {
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
    
    func changeCancleButtonTitle(_ bool: Bool) {
        let title = bool ? "취소" : "이전"
        bottomView.cancleButton.setTitle(title, for: .normal)
    }
    
    func changeNextButtonTitle(_ bool: Bool) {
        let title = bool ? "완료" : "다음"
        bottomView.okButton.setTitle(title, for: .normal)
    }
    
    func changePreviewTitle(_ bool: Bool) {
        self.title = bool ? "미리보기" : "레터등록"
    }
    
    // MARK: - Actions
    @objc func didTapBackButton() {
        writingManager.removeData()
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapCancleButton(_ sender: UIButton) {
        switch page {
        case 0:
            didTapBackButton()
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
    
    @objc func didTapOKButton(_ sender: UIButton) {
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
                NotificationCenter.default.post(
                    name: Notification.Name("validation"),
                    object: nil)
            }
        case 2:
            if writingManager.checkEventInfo() == .success {
                detailViewController.view.removeFromSuperview()
                previewController.preview = self.writingManager.showPreview()
                changeViewController(previewController)
                changePage(false)
            }
        case 3:
//            writingManager.createEvent {
//                self.writingManager.removeData()
//                self.goToInitialViewController()
//            }
            break
        default: break
        }
    }
}
