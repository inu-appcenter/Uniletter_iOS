//
//  BaseViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/05.
//

import UIKit

class BaseViewController: UIViewController,
                          UIGestureRecognizerDelegate {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureNavigationGesutre()
        configureNavigationBar()
        configureUI()
        configureLayout()
    }
    
    // MARK: - Func
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configureNavigationGesutre() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func configureViewController() {
        view.backgroundColor = .white
        
        // override 후, 원하는 작업 추가
    }
    
    func configureNavigationBar() {
        // override 후, 원하는 작업 추가
    }
    
    func configureUI() {
        // override 후, UI 컴포넌트들 addSubView
    }
    
    func configureLayout() {
        // override 후, UI 컴포넌트들 레이아웃 추가
    }
    
}
