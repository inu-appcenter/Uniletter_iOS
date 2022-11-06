//
//  Block.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import Foundation

struct Block: Codable {
    var user: User
    var blockedAt: String
}

struct User: Codable {
    var id: Int
    var email: String
    var nickname: String
    var imageUUID: String?
    var imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case nickname
        case imageUUID = "imageUuid"
        case imageURL = "imageUrl"
    }
}
