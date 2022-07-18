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
    
    func setStartAt() {
        guard let startDate = startDate,
              let startTime = startTime else {
            return
        }
        
        self.startAt = "\(startDate) \(startTime)"
    }
    
    func setEndAt() {
        guard let endDate = endDate,
              let endTime = endTime else {
            return
        }
        
        self.endAt = "\(endDate) \(endTime)"
    }
    
}
