//
//  SceneDelegate.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        //window?.rootViewController = LaunchViewController()
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            let homeViewController = HomeViewController()
//            let navigationController = UINavigationController(rootViewController: homeViewController)
//            navigationController.modalPresentationStyle = .fullScreen
//
//            self.window?.rootViewController = navigationController
//        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
   
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    
    }

    func sceneWillResignActive(_ scene: UIScene) {
    
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    
    }


}

