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
        let dateStr = event.startAt
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
    
    var dday: String {
        return caculateDDay(event.endAt)
    }
    
    var categoryContent: String {
        return "\(event.category) | \(event.host ?? "")"
    }
    
    var startContent: String {
        let date = subDateString(event.startAt)
        let time = subTimeString(event.startAt)
        return "\(date) - \(time)"
    }
    
    
    func eventLoad(_ index: Int) {
        event = EventManager.shared.events[index]
    }
}
