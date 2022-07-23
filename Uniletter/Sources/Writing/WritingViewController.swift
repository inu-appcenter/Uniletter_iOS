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
        default: break
        }
        
        page -= 1
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
                writingManager.createEvent() {
                    self.goToInitialViewController()
                }
            } else {
                // TODO: 필수정보 입력 알림
            }
            
            break
        default: break
        }
        
        page = page >= 2 ? 2 : page + 1
    }
}
