//
//  MyEventViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/13.
//

import Foundation
import UIKit
import Kingfisher

class MyEventViewModel {
    var myEvents = [Event]()
    var eventIdList = [Int]()
    
    var numOfCell: Int {
        return myEvents.count
    }
    
    func getMyEvents(completion: @escaping() -> Void) {
        
        API.getMyEvent { result in
            self.myEvents = result
            self.myEvents = self.sortedEventList(event: self.myEvents)
        }
    }
    
    func sortedEventList(event: [Event]) -> [Event] {
    
        let event = event.sorted(by: { $0.id > $1.id} )
        
        return event
    }
}
