//
//  EventDetailViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import UIKit

final class EventDetailViewModel {
    
    // MARK: - Property
    let manager = EventManager.shared
    let defaultDate = "2022-02-02T00:00"
    
    // MARK: - Func
    var like: Bool {
        return manager.like
    }
    
    var event: Event {
        return manager.event!
    }
    
    var profileImage: UIImage {
        return manager.profileImage
    }
    
    var nickname: String {
        return manager.nickname
    }
    
    var dateWrote: String {
        return manager.dateWrote
    }
    
    var mainImage: UIImage {
        return manager.mainImage
    }
    
    var title: String {
        return manager.title
    }
    
    var endAt: String {
        return manager.endAt
    }
    
    var categoryContent: String {
        return manager.categoryContent
    }
    
    var startContent: String {
        return manager.startContent
    }
    
    var endContent: String {
        return manager.endContent
    }
    
    var target: String {
        return manager.target
    }
    
    var contact: String {
        return manager.contact
    }
    
    var link: String {
        return manager.link
    }
    
    var body: String {
        return manager.body
    }
    
    var views: String {
        return manager.views
    }
    
    var likeAndComments: String {
        return manager.likeAndComments
    }
    
    func changeLikes(_ num: Int) -> String {
        return manager.changeLikes(num)
    }
    
    // MARK: - Funcs
    func likeEvent(completion: @escaping (String) -> Void) {
        guard let id = manager.event?.id else { return }
        API.likeEvent(["eventId": id]) {
            completion(self.changeLikes(1))
        }
    }
    
    func deleteLike(completion: @escaping (String) -> Void) {
        guard let id = manager.event?.id else { return }
        API.deleteLikes(data: ["eventId": id]) {
            completion(self.changeLikes(0))
        }
    }
    
    func loadEvent(_ id: Int, completion: @escaping () -> Void) {
        manager.loadEvent(id) {
            completion()
        }
    }
    
    func postBlock(userId: Int, completion: @escaping () -> Void) {
        manager.postBlock(userId: userId) {
            completion()
        }
    }
}
