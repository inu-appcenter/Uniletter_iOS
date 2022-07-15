//
//  SaveListViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/14.
//

import Foundation

class SaveListViewModel {
    var event = [Event]()
    
    var numOfCell: Int {
        return event.count
    }
    
    func eventAtIndex(index: Int) -> Event {
        return event[index]
    }
    
    func getLike(completion: @escaping() -> Void) {
        API.getLikes { result in
            self.event = result
            completion()
        }
    }
    
    func deleteLike(index: Int, completion: @escaping() -> Void) {
        let data = ["eventId": self.event[index].id]
        API.deleteLikes(data: data) {
            completion()
        
        }
    }
}
