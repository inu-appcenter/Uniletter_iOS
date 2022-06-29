//
//  EventDetailViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import UIKit

class EventDetailViewModel {
    var event: Event = EventManager.shared.events[0]
    
    var profileImage: UIImage {
        guard let imageURL = event.profileImage else {
            return UIImage(named: "BasicProfileImage") ?? UIImage()
        }
        
        let url = URL(string: imageURL)!
        guard let data = try? Data(contentsOf: url) else {
            return UIImage()
        }
        
        return UIImage(data: data) ?? UIImage()
    }
    
    var nickname: String {
        return event.nickname
    }
    
    var dateWrote: String {
        let dateStr = event.createdAt
        return subDateString(dateStr)
    }
    
    var mainImage: UIImage {
        let url = URL(string: event.imageURL)!
        guard let data = try? Data(contentsOf: url) else {
            return UIImage()
        }
        
        return UIImage(data: data) ?? UIImage()
    }
    
    var title: String {
        return event.title
    }
    
    var dday: Int {
        return Int(caculateDDay(event.endAt)) ?? 0
    }
    
    var categoryContent: String {
        return "\(event.category) | \(event.host ?? "")"
    }
    
    var startContent: String {
        let date = subDateString(event.startAt)
        let time = convertTime(event.startAt)
        
        return "\(date) - \(time)"
    }
    
    var endContent: String {
        let date = subDateString(event.endAt)
        let time = convertTime(event.endAt)
        
        return "\(date) - \(time)"
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
        return "저장\(event.likes) ∙ 댓글 \(event.comments)개"
    }
    
    func eventLoad(_ index: Int) {
        event = EventManager.shared.events[index]
    }
}
