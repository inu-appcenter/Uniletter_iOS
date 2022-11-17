//
//  LoginManager.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/05.
//

import UIKit

final class LoginManager {
    
    // MARK: - Init
    static let shared = LoginManager()
    
    private init() { }
      
    // MARK: - Property
    var googleLoginInfo: LoginInfo?
    var appleLoginInfo: LoginInfo?
    var isLoggedIn = false
    var googleLogin = false
    var appleLogin = false
    var firstLogin = false
    
    // MARK: - Funcs
    func checkLogin(completion: @escaping() -> Void) {

        loadLoginInfo()
        
        // 구글 로그인 한 경우
        if googleLogin == true {
            let parameter: [String: Any] = [
                "id": googleLoginInfo!.userID,
                "token": googleLoginInfo!.rememberMeToken
            ]
            
            API.rememberedLogin(parameter) { info in
                guard let info = info else {
                    self.isLoggedIn = false
                    completion()
                    return
                }
                
                self.saveGoogleLoginInfo(info)
                self.isLoggedIn = true
                self.firstLogin = true
                completion()
            }
        }
        
        // 애플 로그인 한 경우
        else if appleLogin == true {
            
            let parameter: [String: Any] = [
                "id": appleLoginInfo!.userID,
                "token": appleLoginInfo!.rememberMeToken
            ]
            
            API.rememberedLogin(parameter) { info in
                guard let info = info else {
                    self.isLoggedIn = false
                    completion()
                    return
                }
                
                self.saveAppleLoginInfo(info)
                self.isLoggedIn = true
                self.firstLogin = true
                completion()
            }
        }
        
        // 둘다 로그인 하지 않은 경우
        else {
            self.isLoggedIn = false
            completion()
        }
    }
    
    func saveGoogleLoginInfo(_ info: LoginInfo) {
        googleLoginInfo = info
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(info),
            forKey: "GoogleLoginInfo")
        print("구글 로그인 정보 저장 완료")
    }
    
    func saveAppleLoginInfo(_ info: LoginInfo) {
        appleLoginInfo = info
        UserDefaults.standard.set(try? PropertyListEncoder().encode(info), forKey: "AppleLoginInfo")
        
        print("애플 로그인 정보 저장 완료")
    }
    
    func logout() {
        
        API.postFcmToken(["token": ""]) {
            guard let cookies = HTTPCookieStorage.shared.cookies else { return }
            
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }

        firstLogin = false
        
        // 구글 로그인, 애플 로그인 분기 처리
        if googleLogin {
            googleLoginInfo = nil
            UserDefaults.standard.removeObject(forKey: "GoogleLoginInfo")
            googleLogin = false
        } else {
            keyChain.delete()
            appleLoginInfo = nil
            UserDefaults.standard.removeObject(forKey: "AppleLoginInfo")
            appleLogin = false
        }
    }
    
    func loadLoginInfo() {
        
        // 구글 로그인 한 경우
        if let data = UserDefaults.standard.data(forKey: "GoogleLoginInfo") {
            
            googleLoginInfo = try? PropertyListDecoder().decode(
                LoginInfo.self,
                from: data)
            
            googleLogin = true
            print("자동 로그인 정보 있음 - 구글")
        }
        
        // 애플 로그인 한 경우
        else if keyChain.read() != "" {
            if let data = UserDefaults.standard.data(forKey: "AppleLoginInfo") {
                
                appleLoginInfo = try? PropertyListDecoder().decode(
                    LoginInfo.self,
                    from: data)
                
                appleLogin = true
                print("자동 로그인 정보 있음 - 애플")
            }
        } else {
            print("자동 로그인 정보 없음")
        }
    }
}
