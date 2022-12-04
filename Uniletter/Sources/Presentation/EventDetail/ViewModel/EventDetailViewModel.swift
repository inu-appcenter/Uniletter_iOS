//
//  EventDetailViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import Foundation

final class EventDetailViewModel {
    
    // MARK: - Property
    
    var event: Event?
    var notiState: NotiState = .request
    let defaultDate = "2022-02-02T00:00"
    
    // MARK: - UI
    
    var wroteByMe: Bool {
        guard let wroteByMe = event?.wroteByMe else {
            return false
        }
        
        return wroteByMe
    }
    
    var like: Bool {
        return event?.likedByMe ?? false
    }
    
    var profileImage: String {
        return event?.profileImage ?? ""
    }
    
    var nickname: String {
        return event?.nickname ?? ""
    }
    
    var dateWrote: String {
        let dateStr = event?.createdAt ?? defaultDate
        
        return CustomFormatter.convertISO8601DateToString(dateStr, "yyyy.MM.dd")
    }
    
    var mainImage: String {
        return event?.imageURL ?? ""
    }
    
    var title: String {
        return event?.title ?? ""
    }
    
    var endAt: String {
        return event?.endAt ?? defaultDate
    }
    
    var categoryContent: String {
        return "\(event?.category ?? "") | \(event?.host ?? "")"
    }
    
    var startContent: String {
        let date = CustomFormatter.subDateString(event?.startAt ?? defaultDate)
        let time = " - " + CustomFormatter.convertTime(event?.startAt ?? defaultDate)
        
        return date + time
    }
    
    var endContent: String {
        let date = CustomFormatter.subDateString(event?.endAt ?? defaultDate)
        let time = " - " + CustomFormatter.convertTime(event?.endAt ?? defaultDate)
        
        return date + time
    }
    
    var target: String {
        return event?.target ?? ""
    }
    
    var contact: String {
        return event?.contact ?? ""
    }
    
    var link: String {
        return event?.location ?? ""
    }
    
    var body: String {
        return event?.body ?? ""
    }
    
    var views: String {
        return "\(event?.views ?? 0)회"
    }
    
    var likeAndComments: String {
        return "저장\(event?.likes ?? 0) ∙ 댓글 \(event?.comments ?? 0)개"
    }
    
    func changeLikes(_ num: Int) -> String {
        return "저장\((event?.likes ?? 0) + num) ∙ 댓글 \(event?.comments ?? 0)개"
    }
    
    // MARK: - Funcs
    
    func loadEvent(_ id: Int, completion: @escaping () -> Void) {
        API.getEventOne(id) { event in
            self.event = event
            completion()
        }
    }
    
    func postBlock(userId: Int, completion: @escaping () -> Void) {
        API.postBlock(data: ["targetUserId": userId]) {
            completion()
        }
    }

    func likeEvent(completion: @escaping (String) -> Void) {
        guard let id = event?.id else { return }
        API.likeEvent(["eventId": id]) {
            completion(self.changeLikes(1))
        }
    }
    
    func deleteLike(completion: @escaping (String) -> Void) {
        guard let id = event?.id else { return }
        API.deleteLikes(data: ["eventId": id]) {
            completion(self.changeLikes(0))
        }
    }
    
    func deleteNotification(completion: @escaping () -> Void) {
        guard let id = event?.id,
              let setFor = event?.notificationSetFor else {
            return
        }
        API.deleteAlarm(data: ["eventId": id, "setFor": setFor], isDetail: true) {
            completion()
        }
    }
    
}
