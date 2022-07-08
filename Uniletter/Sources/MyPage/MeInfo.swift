//
//  MeInfo.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/05.
//

import Foundation

struct Me: Codable {
    var id: Int
    var email: String
    var nickname: String
    var imageUuid: String?
    var imageUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email, nickname
        case imageUuid = "imageUuid"
        case imageUrl = "imageUrl"
    }
}

struct Images: Codable {
    var uuid: String

}

struct Comment: Codable {
    var eventId: Int
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case eventId, content
    }
}


struct myComment: Codable {
    var id: Int
    var userId: Int
    var nickname: String
    var profileImage: String
    var eventId: Int
    var content: String
    var createdAt: String
    var wroteByMe: Bool
}
