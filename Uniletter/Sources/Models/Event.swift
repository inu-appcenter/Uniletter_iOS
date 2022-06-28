//
//  Event.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import Foundation

struct Event: Codable {
    var id: Int
    var userID: Int
    var nickname: String
    var profileImage: String?
    var title: String
    var host: String?
    var category: String
    var target: String
    var startAt: String
    var endAt: String
    var contact: String?
    var location: String?
    var body: String
    var imageUUID: String
    var imageURL: String
    var createdAt: String
    var wroteByMe: Bool?
    var likedByMe: Bool?
    var notificationSetByMe: Bool?
    var notificationSetFor: String?
    var comments: Int
    var views: Int
    var likes: Int
    var notifications: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case nickname, profileImage, title, host, category, target, startAt, endAt, contact, location, body
        case imageUUID = "imageUuid"
        case imageURL = "imageUrl"
        case createdAt, wroteByMe, likedByMe, notificationSetByMe, notificationSetFor, comments, views, likes, notifications
    }
}
