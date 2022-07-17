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
    let pictureViewController = WiritingPictureViewController()
    let contentViewController = WritingContentViewController()
    let detailViewController = WritingDetailViewController()
    var page = 0
    
    
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
        changePictureViewController()
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
    }
    
    // MARK: - Funcs
    func changePictureViewController() {
        pictureViewController.willMove(toParent: self)
        pictureViewController.view.frame = containerView.bounds
        containerView.addSubview(pictureViewController.view)
        pictureViewController.didMove(toParent: self)
    }
    
    func changeContentViewController() {
        contentViewController.willMove(toParent: self)
        contentViewController.view.frame = containerView.bounds
        containerView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
    }
    
    func changeDetailViewController() {
        detailViewController.willMove(toParent: self)
        detailViewController.view.frame = containerView.bounds
        containerView.addSubview(detailViewController.view)
        detailViewController.didMove(toParent: self)
    }
    
    // MARK: - Actions
    @objc func didTapCancleButton(_ sender: UIButton) {
        switch page {
        case 0:
            self.navigationController?.popViewController(animated: true)
        case 1:
            contentViewController.view.removeFromSuperview()
            changePictureViewController()
        case 2:
            detailViewController.view.removeFromSuperview()
            changeContentViewController()
        default: break
        }
        
        page -= 1
    }
    
    @objc func didTapOKButton(_ sender: UIButton) {
        switch page {
        case 0:
            pictureViewController.view.removeFromSuperview()
            changeContentViewController()
        case 1:
            contentViewController.view.removeFromSuperview()
            changeDetailViewController()
        case 2:
            // TODO: 이벤트 등록
            break
        default: break
        }
        
        page = page >= 2 ? 2 : page + 1
    }
}
