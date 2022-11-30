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
    var events = [Event]()
    var ids = [Int]()
    var isPaging = false
    var currentPage = 0
    var isPull = false {
        willSet {
            if newValue {
                events.removeAll()
                currentPage = 0
            }
        }
    }
    var categoty = 0 {
        willSet {
            events.removeAll()
            currentPage = 0
        }
    }
    var eventStatus = true
    
    // MARK: - UI
    var numOfEvents: Int {
        return events.count
    }
    
    func infoOfEvent(_ index: Int) -> Event {
        return events[index]
    }
    
    // MARK: - Funcs
    func likeEvent(_ id: Int) {
        API.likeEvent(["eventId": id]) {
            guard let index: Int = self.ids.firstIndex(of: id) else {
                return
            }
            self.events[index].likedByMe = true
        }
    }
    
    func deleteLike(_ id: Int) {
        API.deleteLikes(data: ["eventId": id]) {
            guard let index: Int = self.ids.firstIndex(of: id) else {
                return
            }
            self.events[index].likedByMe = false
        }
    }
    
    func updateBookmarkButton(id: Int, isChecked: Bool) {
        guard let index: Int = self.ids.firstIndex(of: id) else {
            return
        }
        events[index].likedByMe = isChecked
    }
    
    func loadEvents(completion: @escaping () -> Void) {
        API.getEvents(categoty, false, currentPage) { events in
            if !events.isEmpty {
                self.events += events
                self.ids = self.events.map { $0.id }
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
