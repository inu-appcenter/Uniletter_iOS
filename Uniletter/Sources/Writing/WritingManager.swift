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
    let basicImageUUID =
    [
        "1ec96f4e-970e-6780-792a-5dc26eec006c",     // 기본
        "1ec94c4d-284e-6b70-6eba-0ecc1b8dd491",     // 동아리 / 소모임
        "1ec94c3f-2c9d-6590-1fd7-cb603aa85e1e",     // 학생회
        "1ec94c15-ee15-6f30-8bdd-76769baf2a97",     // 간식나눔
        "1ec94c15-786e-6520-ea08-df4f8c716b04",     // 대회 / 공모전
        "1ec94c49-4fd6-6ca0-1497-d8b902900844",     // 스터디
        "1ec94c42-4e1a-6030-9859-6dc8e7afe7df",     // 구인
        "1ec96f4e-970e-6780-792a-5dc26eec006c",     // 기타
    ]
    var basicImage = "1ec96f4e-970e-6780-792a-5dc26eec006c"
    var title: String?
    var host = ""
    var category = ""
    var target: String?
    var contact = ""
    var location = ""
    var body: String?
    var imageUUID: String?
    var startDate: String?
    var startTime: String?
    var endDate: String?
    var endTime: String?
    
    // MARK: - Funcs
    func setImage(_ image: UIImage) {
        API.uploadMeImage(image: image) { result in
            self.imageUUID = result.uuid
        }
    }
    
    func setStartDate(_ text: String) {
        self.startDate = text
    }
    
    func setStartTime(_ text: String) {
        self.startTime = text
    }
    
    func setEndDate(_ text: String) {
        self.endDate = text
    }
    
    func setEndTime(_ text: String) {
        self.endTime = text
    }
    
    func checkEventInfo() -> Bool {
        guard title != nil,
              target != nil,
              body != nil else {
            return false
        }
        return true
    }
    
    func createEvent() {
        let startAt = "\(startDate ?? convertDefaultDate()) \(startTime ?? "18:00:00")"
        let endAt = "\(endDate ?? convertDefaultDate()) \(endTime ?? "18:00:00")"
        
        let parameter: [String: Any] =
        [
            "title": title!,
            "host": host,
            "category": category,
            "target": target!,
            "startAt": startAt,
            "endAt": endAt,
            "contact": contact,
            "location": location,
            "body": body!,
            "imageUuid": imageUUID ?? basicImage,
        ]
        
        print(parameter)
    }
}
