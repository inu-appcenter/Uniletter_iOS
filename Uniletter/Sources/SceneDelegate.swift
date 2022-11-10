//
//  SceneDelegate.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    // MARK: - Life cycle
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = LaunchViewController()
        window?.makeKeyAndVisible()
        
        presentInitViewController()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
   
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: keyChain.read()!) { credentialState, error in
            switch credentialState {
            case .authorized:
                // 인증 성공 상태
                print("sceneDidBecomeActive - 애플 로그인 인증 성공")
                break
            case .revoked:
                // 인증 만료 상태 (사용자가 백그라운드에서 ID중지했을 경우)
                print("sceneDidBecomeActive - 애플 로그인 인증 만료")
                // 만약 애플 로그인이 로그인 상태였으면 로그아웃 상태로 해야 함
                
                if keyChain.read() != "" {
                    LoginManager.shared.logout()
                    
                    DispatchQueue.main.async {
                        let homeViewController = UINavigationController(rootViewController: HomeViewController())
                        
                        self.window?.rootViewController = homeViewController
                        self.window?.rootViewController?.dismiss(animated: false)
                    }
                }
                
                break
            case .notFound:
                // Credential을 찾을 수 없는 상태 (로그아웃 상태)
                print("sceneDidBecomeActive - 애플 Credential을 찾을 수 없음")
                break
            default:
                break
            }
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
    
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    
    }

}

extension SceneDelegate {
    
    private func presentInitViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if !(UserDefaults.standard.bool(forKey: "agree")) {
                let agreeViewController = AgreementViewController()
                agreeViewController.modalPresentationStyle = .fullScreen
                
                self.window?.rootViewController = agreeViewController
            } else {
                let homeViewController = HomeViewController()
                let navigationController = UINavigationController(rootViewController: homeViewController)
                navigationController.modalPresentationStyle = .fullScreen

                self.window?.rootViewController = navigationController
            }
        }
    }
    
}
