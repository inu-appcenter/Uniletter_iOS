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
    var googleLogin = false
    var appleLogin = false
    
    // MARK: - Funcs
    func checkLogin(completion: @escaping() -> Void) {

        loadLoginInfo()
        
        // 구글 로그인 한 경우
        if googleLogin == true {
            let parameter: [String: Any] = [
                "id": loginInfo!.userID,
                "token": loginInfo!.rememberMeToken
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
        
        // 애플 로그인 한 경우
        if appleLogin == true {
            self.isLoggedIn = true
            completion()
        }
        
        // 둘다 로그인 하지 않은 경우
        if googleLogin == false && appleLogin == false {
            self.isLoggedIn = false
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
        
        if keyChain.read() != "" {
            keyChain.delete()
        }
        
        googleLogin = false
        appleLogin = false
    }
    
    func loadLoginInfo() {
        
        // 구글 로그인 한 경우
        if let data = UserDefaults.standard.data(forKey: "LoginInfo") {
            
            loginInfo = try? PropertyListDecoder().decode(
                LoginInfo.self,
                from: data)
            
            googleLogin = true
        }
        
        // 애플 로그인 한 경우
        if keyChain.read() != "" {
            appleLogin = true
        }
    }
}
