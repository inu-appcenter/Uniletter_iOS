//
//  EventDetailViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import UIKit

final class EventDetailViewModel {
    
    // MARK: - Property
    var event: Event?
    let defaultDate = "2022-02-02T00:00"
    
    // MARK: - UI
    var like: Bool {
        guard let like = event?.likedByMe else {
            return false
        }
        return like
    }
    
    var profileImage: UIImage {
        guard let imageURL = event?.profileImage else {
            return UIImage(named: "BasicProfileImage") ?? UIImage()
        }
        
        let url = URL(string: imageURL)!
        guard let data = try? Data(contentsOf: url) else {
            return UIImage()
        }
        
        return UIImage(data: data) ?? UIImage()
    }
    
    var nickname: String {
        return event?.nickname ?? ""
    }
    
    var dateWrote: String {
        let dateStr = event?.createdAt ?? defaultDate
        return subDateString(dateStr)
    }
    
    var mainImage: UIImage {
        guard let imageURL = event?.imageURL else {
            return UIImage()
        }
        let url = URL(string: imageURL)!
        guard let data = try? Data(contentsOf: url) else {
            return UIImage()
        }
        
        return UIImage(data: data) ?? UIImage()
    }
    
    var title: String {
        return event?.title ?? ""
    }
    
    var dday: Int {
        return Int(caculateDDay(event?.endAt ?? defaultDate)) ?? 0
    }
    
    var categoryContent: String {
        return "\(event?.category ?? "") | \(event?.host ?? "")"
    }
    
    var startContent: String {
        let date = subDateString(event?.startAt ?? defaultDate)
        let time = convertTime(event?.startAt ?? defaultDate)
        
        return "\(date) - \(time)"
    }
    
    var endContent: String {
        let date = subDateString(event?.endAt ?? defaultDate)
        let time = convertTime(event?.endAt ?? defaultDate)
        
        return "\(date) - \(time)"
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
}
