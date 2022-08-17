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
        setNavigationTitleAndBackButton("레터등록")
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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
    @objc func didTapCancleButton(_ sender: UIButton) {
        switch page {
        case 0:
            self.navigationController?.popViewController(animated: true)
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
        
        page -= 1
        page == 0 ? changeCancleButtonTitle(true) : changeCancleButtonTitle(false)
        changePreviewTitle(false)
    }
    
    @objc func didTapOKButton(_ sender: UIButton) {
        switch page {
        case 0:
            pictureViewController.view.removeFromSuperview()
            changeViewController(contentViewController)
        case 1:
            contentViewController.view.removeFromSuperview()
            changeViewController(detailViewController)
        case 2:
            if writingManager.checkEventInfo() {
                detailViewController.view.removeFromSuperview()
                previewController.preview = self.writingManager.showPreview()
                previewController.mainImage = self.writingManager.mainImage
                changeViewController(previewController)
                page += 1
            } else {
                // TODO: 필수정보 입력 알림
            }
        case 3:
//            writingManager.createEvent() {
//                self.goToInitialViewController()
//            }
            break
        default: break
        }
        
        page = page < 2 ? page + 1 : page
        if page == 3 {
            changeNextButtonTitle(true)
            changePreviewTitle(true)
        } else {
            changeNextButtonTitle(false)
        }
        changeCancleButtonTitle(false)
    }
}
