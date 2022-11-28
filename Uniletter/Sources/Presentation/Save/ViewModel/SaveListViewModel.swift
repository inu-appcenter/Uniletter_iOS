//
//  SaveListViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/14.
//

import Foundation

class SaveListViewModel {
    var event = [Event]()
    var pageNum = 0
    var isLast = false

    var numOfCell: Int {
        return event.count
    }
    
    func eventAtIndex(index: Int) -> Event {
        return event[index]
    }
    
    func getLike(completion: @escaping() -> Void) {
        API.getLikes(pageNum: pageNum) { result in
            
            if !result.isEmpty {
                self.event += result
                self.pageNum += 1
            } else {
                self.isLast = true
            }
            
            completion()
        }
    }
    
    func deleteLike(index: Int, completion: @escaping() -> Void) {
    
        let deleteEventId = self.event[index].id
        
        let data = ["eventId": deleteEventId]
        
        API.deleteLikes(data: data) {
            
            self.deleteLikeEvent(deleteEventId)

            NotificationCenter.default.post(
                name: NSNotification.Name("like"),
                object: nil,
                userInfo: [
                    "id": deleteEventId,
                    "like": false
                ])
            
            completion()
        }
    }
    
    func deleteLikeEvent(_ id: Int) {
        self.event = self.event.filter {
            $0.id != id
        }
    }
}
