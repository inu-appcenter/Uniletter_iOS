//
//  Event.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import Foundation

struct Event: Codable {
    let id: Int
    let userID: Int
    let nickname: String
    let profileImage: String?
    let title: String
    let host: String?
    let category: String
    let target: String
    let startAt: String
    let endAt: String
    let contact: String?
    let location: String?
    let body: String
    let imageUUID: String
    let imageURL: String
    let createdAt: String
    let wroteByMe: Bool?
    var likedByMe: Bool?
    let notificationSetByMe: Bool?
    let notificationSetFor: String?
    let comments: Int
    let views: Int
    let likes: Int
    let notifications: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case nickname, profileImage, title, host, category, target, startAt, endAt, contact, location, body
        case imageUUID = "imageUuid"
        case imageURL = "imageUrl"
        case createdAt, wroteByMe, likedByMe, notificationSetByMe, notificationSetFor, comments, views, likes, notifications
    }
}
