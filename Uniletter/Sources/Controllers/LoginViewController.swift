//
//  LoginViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    lazy var launchLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var login: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.setTitle("로그인", for: .normal)
        button.addTarget(self, action: #selector(checkLogin), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setLayout()
    }
    
    func addViews() {
        [launchLogo, login].forEach { view.addSubview($0) }
    }
    
    func setLayout() {
        launchLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
            $0.width.equalTo(150)
            $0.height.equalTo(80)
        }
        
        login.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(40)
            $0.centerY.equalToSuperview().offset(40)
        }
    }
    
    @objc func checkLogin() {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
}
