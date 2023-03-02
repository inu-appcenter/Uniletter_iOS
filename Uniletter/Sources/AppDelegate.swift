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
import CoreData

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

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "EventModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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
