//
//  SearchViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/12/20.
//

import Foundation

class SearchViewModel {
    
    var events = [Event]()
    var pageNum = 0
    var isLast = false
    
    var numOfEvents: Int {
        return events.count
    }
    
    func eventAtIndex(index: Int) -> Event {
        return events[index]
    }
    
    func searchEvent(completion: @escaping() -> Void) {
        API.getEvents(0, false, pageNum) { result in
            if !result.isEmpty {
                self.events += result
                self.pageNum += 1
            } else {
                self.isLast = true
            }
            
            completion()
        }
    }
}

