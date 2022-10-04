//
//  keyChain.swift
//  Uniletter
//
//  Created by 임현규 on 2022/09/09.
//

import UIKit

class keyChain {
    
    class func create(userID: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userID",
            kSecValueData: userID.data(using: .utf8, allowLossyConversion: false) as Any
        ]
        
        SecItemDelete(query)
        
        let status = SecItemAdd(query, nil)
        assert(status == noErr, "아이디 저장 실패")
    }
    
    class func read() -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userID",
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)

        if status == errSecSuccess {
            let retrievedData = dataTypeRef as! Data
            let value = String(data: retrievedData, encoding: String.Encoding.utf8)
            return value
        } else {
            return ""
        }
    }
    
    class func delete() {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "userID"
        ]
        
        let status = SecItemDelete(query)
        assert(status == noErr, "아이디 삭제 실패")
    }
}
