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
    var loginInfo: LoginInfo?
    var isLoggedIn = false
    
    // MARK: - Funcs
    func checkLogin(completion: @escaping() -> Void) {

        loadLoginInfo()
        
        guard let loginInfo = loginInfo else {
            // 구글 로그인 정보가 없는 경우

            // 만약 애플 로그인 정보가 있으면
            if let appleUserId = keyChain.read(key: "userID") {
                print("LoginManager - checkLogin : 애플 유저 아이디 = \(appleUserId)")
                // 이후 로직 나중에 구현
                // self.isLoggedIn = true
                // completion()
                
            }
            
            // 구글 로그인, 애플 로그인 둘다 정보가 없는 경우
            self.isLoggedIn = false
            completion()
            return
        }
        
        // 구글 로그인 정보가 있는 경우
        let parameter: [String: Any] = [
            "id": loginInfo.userID,
            "token": loginInfo.rememberMeToken
        ]
        
        API.rememberedLogin(parameter) { info in
            guard let info = info else {
                self.isLoggedIn = false
                completion()
                return
            }
            
            self.saveLoginInfo(info)
            self.isLoggedIn = true
            completion()
        }
    }
    
    func saveLoginInfo(_ info: LoginInfo) {
        loginInfo = info
        UserDefaults.standard.set(
            try? PropertyListEncoder().encode(info),
            forKey: "LoginInfo")
        print("로그인 정보 저장 완료")
    }
    
    func logout() {
        guard let cookies = HTTPCookieStorage.shared.cookies else { return }
        
        for cookie in cookies {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
        
        loginInfo = nil
        UserDefaults.standard.removeObject(forKey: "LoginInfo")
        
        keyChain.delete(key: "userID")
    }
    
    func loadLoginInfo() {

        var googleLogin: Bool
        var appleLogin: Bool
        
        // 구글 로그인 한 경우
        if let data = UserDefaults.standard.data(forKey: "LoginInfo") {
            
            loginInfo = try? PropertyListDecoder().decode(
                LoginInfo.self,
                from: data)
            
            googleLogin = true
            
        } else { googleLogin = false }
        
        // 애플 로그인 한 경우
        if let userId = keyChain.read(key: "userID") {
            
            appleLogin = true
        } else {
            appleLogin = false
        }
        
        if appleLogin == false, googleLogin == false {
            print("loadLoginInfo() - 로그인 정보 없음")
        } else if appleLogin == true, googleLogin == false {
            print("loadLoginInfo() - 애플 로그인 정보 있음, 구글 로그인 정보 없음")
        } else if appleLogin == false, googleLogin == true {
            print("loadLoginInfo() - 애플 로그인 정보 있음, 구글 로그인 정보 있음")
        }

    }
}
