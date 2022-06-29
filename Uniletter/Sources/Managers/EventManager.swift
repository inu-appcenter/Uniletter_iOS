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
    
    func formatStartAt() {
        
    }
    
    func formatEndAt() {
        
    }
}
