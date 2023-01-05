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
    
    // TODO: 복붙만 임시로 해뒀으니 기능 추가할 때 현규님 스타일로 정리하시면 될거에요!
    private var currentPage = 0
    var categoty = 0 {
        willSet { removeEvents() }
    }
    var eventStatus = true {
        willSet { removeEvents() }
    }
    let eventStatusList = ["전체", "진행중"]
    let categoryList = ["전체", "동아리/소모임", "학생회", "간식나눔", "대회/공모전", "스터디", "구인", "기타"]
    
    var numOfEvents: Int {
        return events.count
    }
    
    func eventAtIndex(index: Int) -> Event {
        return events[index]
    }
    
    private func removeEvents() {
        events.removeAll()
        currentPage = 0
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

