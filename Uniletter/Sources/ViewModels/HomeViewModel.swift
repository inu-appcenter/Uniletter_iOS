//
//  HomeViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import Foundation

class HomeViewModel {
    let manager = EventManager.shared
    
    var numOfEvents: Int {
        return manager.events.count
    }
    
    func infoOfEvent(_ index: Int) -> Event {
        return manager.events[index]
    }
}
