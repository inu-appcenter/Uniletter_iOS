//
//  LoginViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import GoogleSignIn
import SnapKit

class LoginViewController: UIViewController {

    let config = GIDConfiguration(clientID: "295205896616-up393se5bofg6ntuqjeksbimk04rg14q.apps.googleusercontent.com")

    lazy var launchLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var googleloginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor.customColor(.lightGray)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("로그인", for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setLayout()
    }
    
    func addViews() {
        [launchLogo, googleloginButton].forEach { view.addSubview($0) }
    }
    
    func setLayout() {
        launchLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
            $0.width.height.equalTo(200)
        }
        
        googleloginButton.snp.makeConstraints {
            $0.top.equalTo(launchLogo.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(20)
        }
    }
    
    @objc func didTapLoginButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { user, error in
            guard error == nil else {
                print(error!)
                return }
            guard let user = user else { return }

            user.authentication.do { authentication, error in
                guard error == nil else {
                    print(error!)
                    return
                }
                guard let authentication = authentication else { return }
                
                let token = authentication.accessToken
                
                API.oAuthLogin(["accessToken" : token]) { info in
                    
                }
            }
        }
//        let viewController = HomeViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.modalPresentationStyle = .fullScreen
//
//        present(navigationController, animated: true)
    }
}
