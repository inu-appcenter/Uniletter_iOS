//
//  EventDetailViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import Foundation

final class EventDetailViewModel {
    
    // MARK: - Property
    
    private var id: Int
    private var event: Event!
    var notiState: NotiState = .request
    
    // MARK: - Init
    
    init(id: Int) {
        self.id = id
    }
    
    // MARK: - Output
    
    var eventInfo: Event {
        return event
    }
    
    var userID: Int {
        return event.userID
    }
    
    var wroteByMe: Bool {
        guard let wroteByMe = event.wroteByMe else {
            return false
        }
        
        return wroteByMe
    }
    
    var like: Bool {
        return event.likedByMe ?? false
    }
    
    var profileImage: String {
        return event.profileImage ?? ""
    }
    
    var nickname: String {
        return event.nickname
    }
    
    var dateWrote: String {
        return CustomFormatter.convertISO8601DateToString(event.createdAt, "yyyy.MM.dd", false)
    }
    
    var mainImage: String {
        return event.imageURL
    }
    
    var title: String {
        return event.title
    }
    
    var endAt: String {
        return event.endAt
    }
    
    var categoryContent: String {
        if let host = event.host {
            return "\(event.category) | \(host)"
        } else {
            return "\(event.category)"
        }
    }
    
    var startContent: String {
        let date = CustomFormatter.subDateString(event.startAt)
        let time = " - " + CustomFormatter.convertTime(event.startAt)
        
        return date + time
    }
    
    var endContent: String {
        let date = CustomFormatter.subDateString(event.endAt)
        let time = " - " + CustomFormatter.convertTime(event.endAt)
        
        return date + time
    }
    
    var target: String {
        return event.target
    }
    
    var contact: String {
        return event.contact ?? ""
    }
    
    var link: String {
        return event.location ?? ""
    }
    
    var body: String {
        return event.body
    }
    
    var views: String {
        return "\(event.views)회"
    }
    
    var likeAndComments: String {
        return "저장 \(event.likes) ∙ 댓글 \(event.comments)개"
    }
    
    var notiSetByMe: Bool? {
        return event.notificationSetByMe
    }
    
    func changeLikes(_ num: Int) -> String {
        return "저장\((event.likes) + num) ∙ 댓글 \(event.comments)개"
    }
    
    // MARK: - Funcs
    
    func loadEvent(completion: @escaping () -> Void) {
        API.getEventOne(id) { [weak self] event in
            self?.event = event
            if let notiByMe = event.notificationSetByMe {
                self?.notiState = notiByMe ? .cancel : .request
            }
            completion()
        }
    }
    
    func postBlock(userId: Int, completion: @escaping () -> Void) {
        API.postBlock(data: ["targetUserId": userId]) {
            completion()
        }
    }

    func likeEvent(completion: @escaping (String) -> Void) {
        API.likeEvent(["eventId": id]) {
            completion(self.changeLikes(1))
        }
    }
    
    func deleteEvent(completion: @escaping () -> Void) {
        API.deleteEvent(id) {
            completion()
        }
    }
    
    func deleteLike(completion: @escaping (String) -> Void) {
        API.deleteLikes(data: ["eventId": id]) {
            completion(self.changeLikes(0))
        }
    }
    
    func deleteNotification(completion: @escaping () -> Void) {
        guard let setFor = event.notificationSetFor else {
            return
        }
        
        API.deleteAlarm(data: ["eventId": id, "setFor": setFor], isDetail: true) {
            completion()
        }
    }
    
}
