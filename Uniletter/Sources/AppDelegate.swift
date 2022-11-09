//
//  AppDelegate.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import GoogleSignIn
import Firebase
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GIDSignIn.sharedInstance.restorePreviousSignIn()
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = .white
        navigationBarAppearance.shadowColor = .clear
        
        /// 네비게이션 제목 위치 왼쪽으로 옮기기
        let titlePosition = -(UIScreen.main.bounds.width / 2 - 40)
        navigationBarAppearance.titlePositionAdjustment = .init(
            horizontal: titlePosition,
            vertical: 2)
        navigationBarAppearance.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22, weight: .black)]
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        
        // Firebase setting
        if #available(iOS 12.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(
                options: [.alert, .sound, .badge, .providesAppNotificationSettings],
                completionHandler: { didAllow,Error in }
            )} else {
                UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .sound, .badge],
                    completionHandler: {didAllow,Error in
                        print(didAllow)
                    })
            }
        
        UNUserNotificationCenter.current().delegate = self
                
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
                
        application.registerForRemoteNotifications()
        
        // MARK: 애플 로그인
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: keyChain.read()!) { credentialState, error in
            switch credentialState {
            case .authorized:
                // 인증 성공 상태
                UserDefaults.standard.removeObject(forKey: "GoogleLoginInfo")
                print("애플 로그인 인증 성공")
                break
            case .revoked:
                // 인증 만료 상태 (사용자가 백그라운드에서 ID중지했을 경우)
                print("애플 로그인 인증 만료")
                // 만약 애플 로그인이 로그인 상태였으면 로그아웃 상태로 해야 함
                
                if keyChain.read() != "" {
                    LoginManager.shared.logout()
                }
        
                break
            case .notFound:
                // Credential을 찾을 수 없는 상태 (로그아웃 상태)
                print("애플 Credential을 찾을 수 없음")
                break
            default:
                break
            }
        }
        return true
    }
    
    // MARK: 구글 로그인
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
          print("[Log] deviceToken :", deviceTokenString)
            
          Messaging.messaging().apnsToken = deviceToken
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        let firebaseToken = fcmToken ?? ""
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .banner, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
