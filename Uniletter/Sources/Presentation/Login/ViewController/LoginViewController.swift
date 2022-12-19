//
//  LoginViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

final class LoginViewController: BaseViewController {
    
    // MARK: - Property
    
    private let loginView = LoginView()
    private let config = GIDConfiguration(
        clientID: "295205896616-up393se5bofg6ntuqjeksbimk04rg14q.apps.googleusercontent.com")
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        loginView.googleLoginButton.addTarget(
            self,
            action: #selector(didTapGoogleLoginButton),
            for: .touchUpInside)
        loginView.appleLoginButton.addTarget(
            self,
            action: #selector(didTapAppleLoginButton),
            for: .touchUpInside)
    }
    
    // MARK: - Func
    
    private func didSuccessdAppleLogin(_ code: Data, _ user: String) {
        let autorizationCodeStr = String(data: code, encoding: .utf8)
        let parameter = ["accessToken": autorizationCodeStr!]
        
        API.appleOAuthLogin(parameter) { [weak self] info in
            DispatchQueue.main.async {
                print("appleOAutoLogin 응답: \(info)")
                LoginManager.shared.saveAppleLoginInfo(info)
                keyChain.create(userID: user)
                
                self?.goToInitialViewController()
            }
        }
    }
    
    // MARK: - Action
    
    @objc private func didTapGoogleLoginButton() {
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
                
                API.googleOAuthLogin(parameter) { info in
                    print("google login info : \(info)")
                    DispatchQueue.main.async {
                        LoginManager.shared.saveGoogleLoginInfo(info)
                        self.goToInitialViewController()
                    }
                }
            }
        }
    }
    
    @objc private func didTapAppleLoginButton() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
}

// MARK: - Apple Login Delegate

extension LoginViewController: ASAuthorizationControllerDelegate {

    // 성공 후 동작
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization)
    {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let code = credential.authorizationCode else {
            return
        }
        
        didSuccessdAppleLogin(code, credential.user)
    }
    
    // 실패 후 동작
    func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error)
    {
        print("애플 로그인 실패")
    }
}
