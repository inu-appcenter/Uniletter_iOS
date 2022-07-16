//
//  HomeViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/03.
//

import Foundation

final class HomeViewModel {
    
    // MARK: - Property
    var events = [Event]()
    var ids = [Int]()
    
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
        API.getEvents() { events in
            self.events = events
            self.ids = events.map { $0.id }
            completion()
        }
    }
}
