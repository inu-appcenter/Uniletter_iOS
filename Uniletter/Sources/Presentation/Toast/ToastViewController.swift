//
//  ToastViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/07.
//

import Toast_Swift
import UIKit

final class ToastViewController: BaseViewController {
    
    // MARK: - Property
    
    private var type: Warning
    
    // MARK: - Init
    
    init(_ type: Warning) {
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentToastMessage()
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        view.backgroundColor = .clear
    }
    
    // MARK: - Func
    
    private func presentToastMessage() {
        let width = UIScreen.main.bounds.width
        let y = UIScreen.main.bounds.height / 1.25
        
        let warningView = WarningView(frame: CGRect(x: 0, y: 0, width: width - 40, height: 52))
        warningView.warninglabel.text = type.body
        
        view.showToast(
            warningView,
            duration: 0.5,
            point: CGPoint(x: width / 2, y: y)) { _ in
                self.dismiss(animated: false)
            }
    }
    
}
