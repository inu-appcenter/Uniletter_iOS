//
//  WritingManager.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/18.
//

import UIKit

final class WritingManager {
    
    static let shared = WritingManager()
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Property
    var basicImage = true
    var image: UIImage?
    var title: String?
    var host: String?
    var category: String?
    var target: String?
    var startAt: String?
    var endAt: String?
    var contact: String?
    var location: String?
    var body: String?
    var imageUUID: String?
    var startDate: String?
    var startTime: String?
    var endDate: String?
    var endTime: String?
    
    // MARK: - Funcs
    func setImage(_ image: UIImage) {
        self.image = image
        // TODO: API 호출하여 UUID 얻기
    }
    
    func setTitle(_ text: String) {
        self.title = text
    }
    
    func setHost(_ text: String) {
        self.host = text
    }
    
    func setCategory(_ text: String) {
        self.category = text
    }
    
    func setTarget(_ text: String) {
        self.target = text
    }
    
    func setStartDate(_ text: String) {
        self.startDate = text
    }
    
    func setStartTime(_ text: String) {
        self.startTime = text
    }
    
    func setStartAt() {
        guard let startDate = startDate,
              let startTime = startTime else {
            return
        }
        
        self.startAt = "\(startDate) \(startTime)"
    }
    
    func setEndDate(_ text: String) {
        self.endDate = text
    }
    
    func setEndTime(_ text: String) {
        self.endTime = text
    }
    
    func setEndAt() {
        guard let endDate = endDate,
              let endTime = endTime else {
            return
        }
        
        self.endAt = "\(endDate) \(endTime)"
    }
    
    func setContact(_ text: String) {
        self.contact = text
    }
    
    func setLocation(_ text: String) {
        self.location = text
    }
    
    func setBody(_ text: String) {
        self.body = text
    }
    
}
