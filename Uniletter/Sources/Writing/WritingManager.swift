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
        "1ec94c4d-284e-6b70-6eba-0ecc1b8dd491",     // 동아리 / 소모임
        "1ec94c3f-2c9d-6590-1fd7-cb603aa85e1e",     // 학생회
        "1ec94c15-ee15-6f30-8bdd-76769baf2a97",     // 간식나눔
        "1ec94c15-786e-6520-ea08-df4f8c716b04",     // 대회 / 공모전
        "1ec94c49-4fd6-6ca0-1497-d8b902900844",     // 스터디
        "1ec94c42-4e1a-6030-9859-6dc8e7afe7df",     // 구인
        "1ec96f4e-970e-6780-792a-5dc26eec006c",     // 기타
    ]
    var basicImage = "1ec96f4e-970e-6780-792a-5dc26eec006c"
    var mainImage = UIImage(named: "uniletter_big")
    var title: String?
    var host = ""
    var category = ""
    var target: String?
    var contact = ""
    var location = ""
    var body = ""
    var imageUUID: String?
    var startDate: String?
    var startTime: String?
    var endDate: String?
    var endTime: String?
    
    // MARK: - Funcs
    func setImage(_ image: UIImage) {
        self.mainImage = image
        
        API.uploadMeImage(image: image) { result in
            self.imageUUID = result.uuid
        }
    }
    
    func checkEventInfo() -> Int {
        if title == nil {
            // TODO:  유효성 검사
        }
        
        return 0
    }
    
    func showPreview() -> Preview {
        let preview = Preview(
            imageUUID: "",
            title: self.title!,
            host: self.host,
            category: self.category,
            target: self.target!,
            startAt: "\(startDate ?? convertDefaultDate()) \(startTime ?? "18:00:00")",
            endAt: "\(endDate ?? convertDefaultDate()) \(endTime ?? "18:00:00")",
            contact: self.contact,
            location: self.location,
            body: self.body)
        
        return preview
    }
    
    func createEvent(completion: @escaping () -> Void) {
        let startAt = "\(startDate ?? convertDefaultDate()) \(startTime ?? "18:00:00")"
        let endAt = "\(endDate ?? convertDefaultDate()) \(endTime ?? "18:00:00")"
        
        let parameter: [String: String] =
        [
            "title": title!,
            "host": host,
            "category": category,
            "target": target!,
            "startAt": startAt,
            "endAt": endAt,
            "contact": contact,
            "location": location,
            "body": body,
            "imageUuid": imageUUID ?? basicImage,
        ]
        
        API.createEvent(parameter) {
            print("이벤트 생성 성공")
            completion()
        }
    }
}
