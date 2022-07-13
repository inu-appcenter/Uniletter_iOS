//
//  Comment.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import Foundation

struct Comment: Codable {
    let id: Int
    let userID: Int
    let nickname: String
    let profileImage: String
    let eventID: Int
    let content: String
    var createdAt: String
    let wroteByMe: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case nickname, profileImage
        case eventID = "eventId"
        case content, createdAt, wroteByMe
    }
}
