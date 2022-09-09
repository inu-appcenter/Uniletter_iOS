//
//  LoginViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import GoogleSignIn
import SnapKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    
    // MARK: - Property
    let config = GIDConfiguration(clientID: "295205896616-up393se5bofg6ntuqjeksbimk04rg14q.apps.googleusercontent.com")
    
    // MARK: - UI
    lazy var launchLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var googleLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor.customColor(.lightGray)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("구글 계정으로 로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(didTapLoginButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var appleLoginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor.customColor(.lightGray)
        button.setTitleColor(.black, for: .normal)
        button.setTitle("애플 계정으로 로그인", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(didTapAppleLoginButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let googleLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "google")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let appleLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "applelogo")
        imageView.tintColor = UIColor.customColor(.lightGray)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setLayout()
    }
    
    // MARK: - Setup
    func addViews() {
        [
            launchLogo,
            googleLoginButton,
            appleLoginButton,
            googleLogo,
            appleLogo,
        ]
            .forEach { view.addSubview($0) }
    }
    
    func setLayout() {
        launchLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
            $0.width.height.equalTo(200)
        }
        
        googleLoginButton.snp.makeConstraints {
            $0.top.equalTo(launchLogo.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        googleLogo.snp.makeConstraints {
            $0.top.bottom.equalTo(googleLoginButton).inset(8)
            $0.left.equalTo(googleLoginButton).offset(16)
            $0.width.equalTo(googleLogo.snp.height)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(googleLoginButton.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
        
        appleLogo.snp.makeConstraints {
            $0.top.bottom.equalTo(appleLoginButton).inset(8)
            $0.left.equalTo(appleLoginButton).offset(16)
            $0.width.equalTo(appleLogo.snp.height)
        }
    }
    
    func goToHomeViewController() {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        present(navigationController, animated: true)
    }
    
    // MARK: - 구글 로그인
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
                let parameter = ["accessToken": token]
                
                DispatchQueue.global().async {
                    API.oAuthLogin(parameter) { info in
                        DispatchQueue.main.async {
                            LoginManager.shared.saveLoginInfo(info)
                            self.goToHomeViewController()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - 애플 로그인
    @objc func didTapAppleLoginButton(_ sender: UIButton) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as? ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {

    // 성공 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let idToken = credential.identityToken!
            let tokeStr = String(data: idToken, encoding: .utf8)
            print("token = \(tokeStr)")

            guard let code = credential.authorizationCode else { return }
            let codeStr = String(data: code, encoding: .utf8)
            print("code = \(codeStr)")

            let user = credential.user
            print("user = \(user)")
        }
    }
    
    // 실패 후 동작
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("애플 로그인 실패")
    }
}
