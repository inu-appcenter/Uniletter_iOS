//
//  AlarmViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import Foundation

class NotiViewModel {
    var notis = [Noti]()
    
    var numOfcell: Int {
        return notis.count
    }
    
    func eventAtIndex(index: Int) -> Event {
        return notis[index].event
    }
    
    func getAlarm(completion: @escaping() -> Void) {
        API.getAlarm { result in
            print(result)
            self.notis = result
            completion()
        }
    }
    
    func deleteAlarm(index: Int, completion: @escaping() -> Void) {
        API.deleteAlarm(data: ["eventId": notis[index].event.id, "setFor": notis[index].setFor]) {
            completion()
        }
    }
}
