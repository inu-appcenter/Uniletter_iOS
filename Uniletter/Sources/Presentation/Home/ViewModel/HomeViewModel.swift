//
//  HomeViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/03.
//

import Foundation
import Firebase

final class HomeViewModel {
    
    // MARK: - Property
    
    private var events: [Event] = [] {
        didSet { eventIds = events.map { $0.id } }
    }
    private var eventIds: [Int] = []
    private var currentPage = 0
    var isPaging = false
    var isPull = false {
        willSet {
            if newValue {
                removeEvents()
            }
        }
    }
    var categoty = 0 {
        willSet { removeEvents() }
    }
    var eventStatus = false {
        willSet { removeEvents() }
    }
    
    
    // MARK: - Output
    
    let eventStatusList = ["전체", "진행중"]
    let categoryList = ["전체", "동아리/소모임", "학생회", "간식나눔", "대회/공모전", "스터디", "구인", "기타"]
    
    var numOfEvents: Int {
        return events.count
    }
    
    func infoOfEvent(_ index: Int) -> Event {
        return events[index]
    }
    
    // MARK: - Func
    
    private func removeEvents() {
        events.removeAll()
        currentPage = 0
    }
    
    func updateLikes(_ id: Int, _ state: Bool) {
        guard let index: Int = eventIds.firstIndex(of: id) else {
            return
        }
        events[index].likedByMe = state
    }
    
    func likeEvent(_ id: Int) {
        API.likeEvent(["eventId": id]) { [weak self] in
            self?.updateLikes(id, true)
        }
    }
    
    func deleteLike(_ id: Int) {
        API.deleteLikes(data: ["eventId": id]) { [weak self] in
            self?.updateLikes(id, false)
        }
    }
    
    func loadEvents(completion: @escaping () -> Void) {
        API.getEvents(categoty, eventStatus, currentPage) { events in
            if !events.isEmpty {
                self.events += events
                self.currentPage += 1
                self.isPaging = false
                self.isPull = false
            }
            
            completion()
        }
    }
    
    func postFCM() {
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                API.postFcmToken(["token": token]) {
                    print("FCM registration token: \(token)")
                }
            }
        }
    }
    
}
