//
//  AppDelegate.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import AuthenticationServices
import Firebase
import GoogleSignIn
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GIDSignIn.sharedInstance.restorePreviousSignIn()
        
        configureFirebase()
        configureNavigationBarAppearence()
        appleLogin()
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    // MARK: - Func
    
    func configureFirebase() {
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
    }
    
    func configureNavigationBarAppearence() {
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
    }

}

// MARK: - Social login

extension AppDelegate {

    // Google
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    // Apple
    func appleLogin() {
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
                    LoginManager.shared.logout { }
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
    }
    
}

// MARK: - Push notification

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

// MARK: UISceneSession Lifecycle

extension AppDelegate {
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
          print("[Log] deviceToken :", deviceTokenString)
            
          Messaging.messaging().apnsToken = deviceToken
    }
    
}
