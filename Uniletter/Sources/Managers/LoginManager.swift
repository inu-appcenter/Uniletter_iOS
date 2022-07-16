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
            self.isLoggedIn = false
            completion()
            return
        }
        
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
            print(info)
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
    }
    
    func loadLoginInfo() {
        guard let data = UserDefaults.standard.data(forKey: "LoginInfo") else {
            print("로그인 정보 없음")
            return
        }
        
        loginInfo = try? PropertyListDecoder().decode(
            LoginInfo.self,
            from: data)
    }
}
