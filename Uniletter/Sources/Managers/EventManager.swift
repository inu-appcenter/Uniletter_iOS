//
//  EventManager.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import Foundation

class EventManager {
    
    static let shared = EventManager()
    
    var events = [Event]()
    
    private init() { }
    
    var numOfEvents: Int {
        return events.count
    }
    
    func infoOfEvent(_ index: Int) -> Event {
        return events[index]
    }
    
    func formatEndAt() {
        let dday = events.map { $0.endAt }
        if dday.count > 0 {
            for i in 0...dday.count - 1 {
                events[i].endAt = caculateDDay(dday[i])
            }
        }
    }
}
