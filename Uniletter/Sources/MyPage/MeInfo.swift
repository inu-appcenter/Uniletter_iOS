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
