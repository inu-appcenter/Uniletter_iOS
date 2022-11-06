//
//  LoginInfo.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/05.
//

import Foundation

struct LoginInfo: Codable {
    let jwt: String
    let userID: Int
    let rememberMeToken: String
    
    enum CodingKeys: String, CodingKey {
        case jwt, rememberMeToken
        case userID = "userId"
    }
}
