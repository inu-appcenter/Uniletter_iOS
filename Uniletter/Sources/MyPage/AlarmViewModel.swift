//
//  AlarmViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import Foundation

class AlarmViewModel {
    var notis = [Noti]()
    
    var numOfcell: Int {
        return notis.count
    }
    
    func eventAtIndex(index: Int) -> Event {
        return notis[index].event
    }
    
    func getAlarm(completion: @escaping() -> Void) {
        API.getAlarm { result in
            self.notis = result
            completion()
        }
    }
}
