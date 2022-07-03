//
//  HomeViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/03.
//

import Foundation

class HomeViewModel {
    
    var events = [Event]()
    
    var numOfEvents: Int {
        return events.count
    }
    
    func infoOfEvent(_ index: Int) -> Event {
        return events[index]
    }
    
    func loadEvents(completion: @escaping () -> Void) {
        API.getEvents() { events in
            self.events = events
            completion()
        }
    }
}
