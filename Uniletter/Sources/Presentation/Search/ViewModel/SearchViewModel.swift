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
    
    var searchContent = "" {
        willSet { removeEvents() }
    }

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
        pageNum = 0
        isLast = false
    }
    
    func updateBookMarkByDetailVC(index: Int, isLiked: Bool) {
        events[index].likedByMe = isLiked
    }
    
    func updateBookMark(index: Int, isLiked: Bool) {
    
        events[index].likedByMe = !isLiked
        
        if isLiked {
            API.deleteLikes(data: ["eventId": events[index].id]) {
                NotificationCenter.default.post(
                    name: NSNotification.Name("like"),
                    object: nil,
                    userInfo: [
                        "id": self.events[index].id,
                        "like": false
                    ])
            }
        } else {
            API.likeEvent(["eventId": events[index].id]) {
                NotificationCenter.default.post(
                    name: NSNotification.Name("like"),
                    object: nil,
                    userInfo: [
                        "id": self.events[index].id,
                        "like": true
                    ])
            }
        }
    }
    
    func filterEvent(completion: @escaping() -> Void) {
        API.searchEvent(category: categoty, eventStatus: eventStatus, content: searchContent, pageNum: pageNum) { result in
            if !result.isEmpty {
                self.events += result
                self.pageNum += 1
            } else {
                self.isLast = true
            }
            completion()
        }
    }
    
    func fetchEvent(completion: @escaping() -> Void) {
        API.searchEvent(category: 0, eventStatus: false, content: searchContent, pageNum: pageNum) { result in
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

