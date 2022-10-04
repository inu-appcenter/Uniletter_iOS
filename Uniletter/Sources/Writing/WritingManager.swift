//
//  WritingManager.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/18.
//

import UIKit

enum BasicInfo {
    case none        // 선택없음, 기타
    case group       // 동아리, 소모임
    case council     // 학생회
    case snacks      // 간식나눔
    case contest     // 대회, 공모전
    case study       // 스터디
    case offer       // 구인
    
    var uuid: String {
        switch self {
        case .none: return "1ec96f4e-970e-6780-792a-5dc26eec006c"
        case .group: return "1ec94c4d-284e-6b70-6eba-0ecc1b8dd491"
        case .council: return "1ec94c3f-2c9d-6590-1fd7-cb603aa85e1e"
        case .snacks: return "1ec94c15-ee15-6f30-8bdd-76769baf2a97"
        case .contest: return "1ec94c15-786e-6520-ea08-df4f8c716b04"
        case .study: return "1ec94c49-4fd6-6ca0-1497-d8b902900844"
        case .offer: return "1ec94c42-4e1a-6030-9859-6dc8e7afe7df"
        }
    }
    
    var image: UIImage {
        switch self {
        case .none: return UIImage(named: "uniletter_big")!
        case .group: return UIImage(named: "Club_p")!
        case .council: return UIImage(named: "StudentCountcil_p")!
        case .snacks: return UIImage(named: "Sharing_p")!
        case .contest: return UIImage(named: "Competition_p")!
        case .study: return UIImage(named: "Study_p")!
        case .offer: return UIImage(named: "Job_p")!
        }
    }
}

enum WritingValidation {
    case success
    case title
    case target
    case both
}

final class WritingManager {
    
    static let shared = WritingManager()
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Property
    var basicImage = BasicInfo.none.uuid
    var imageIndex = 0
    var mainImage = BasicInfo.none.image
    var imageType: ImageType = .basic
    var title: String?
    var host = ""
    var category = ""
    var target: String?
    var contact = ""
    var location = ""
    var body = ""
    var imageUUID: String?
    var startDate = CustomFormatter.convertTodayToString(true)
    var startTime = CustomFormatter.convertNowTime(false)
    var endDate = CustomFormatter.convertTodayToString(true)
    var endTime = CustomFormatter.convertNowTime(false)
    
    // MARK: - Funcs
    
    func removeData() {
        self.basicImage = BasicInfo.none.uuid
        self.imageType = .basic
        self.mainImage = BasicInfo.none.image
        self.title = nil
        self.host = ""
        self.category = ""
        self.target = nil
        self.contact = ""
        self.location = ""
        self.body = ""
        self.imageUUID = nil
        self.startDate = CustomFormatter.convertTodayToString(true)
        self.startTime = CustomFormatter.convertNowTime(false)
        self.endDate = CustomFormatter.convertTodayToString(true)
        self.endTime = CustomFormatter.convertNowTime(false)
    }
    
    func setImage(_ image: UIImage) {
        self.mainImage = image
        self.imageType = .custom
        
        API.uploadMeImage(image: image) { result in
            self.imageUUID = result.uuid
        }
    }
    
    func setBasicImage() {
        switch self.imageIndex {
        case 0, 7: changeImage(.none)
        case 1: changeImage(.group)
        case 2: changeImage(.council)
        case 3: changeImage(.snacks)
        case 4: changeImage(.contest)
        case 5: changeImage(.study)
        case 6: changeImage(.offer)
        default: break
        }
    }
    
    func changeImage(_ basic : BasicInfo) {
        self.basicImage = basic.uuid
        
        if self.imageType == .basic {
            self.mainImage = basic.image
        }
    }
    
    func equalDateTime() {
        self.endDate = self.startDate
        self.endTime = self.startTime
    }
    
    func convertTime(_ isStart: Bool) -> String {
        let hour = isStart
        ? Int(self.startTime.subStringByIndex(sOffset: 0, eOffset: 2))!
        : Int(self.endTime.subStringByIndex(sOffset: 0, eOffset: 2))!

        let min = isStart
        ? self.startTime.subStringByIndex(sOffset: 3, eOffset: 5)
        : self.endTime.subStringByIndex(sOffset: 3, eOffset: 5)
        
        if hour >= 12 {
            return (" - \(hour % 12):\(min) 오후")
        } else {
            return (" - \(hour):\(min) 오전")
        }
    }
    
    func checkEventInfo() -> WritingValidation {
        if self.title == nil || self.title == "" {
            return (self.target == nil || self.target == "") ? .both : .title
        } else {
            return (self.target == nil || self.target == "") ? .target : .success
        }
    }
    
    func showPreview() -> Preview {
        setBasicImage()
        
        let preview = Preview(
            mainImage: self.mainImage,
            imageType: self.imageType,
            imageUUID: self.imageUUID ?? self.basicImage,
            title: self.title!,
            host: self.host,
            category: self.category,
            target: self.target!,
            startAt: self.startDate + "T" + self.startTime + ".000+09:00",
            endAt: self.endDate + "T" + self.endTime + ".000+09:00",
            contact: self.contact,
            location: self.location,
            body: self.body)
        
        return preview
    }
    
    func createEvent(completion: @escaping () -> Void) {
        let parameter: [String: String] =
        [
            "title": self.title!,
            "host": self.host,
            "category": self.category,
            "target": self.target!,
            "startAt": self.startDate + " " + self.startTime,
            "endAt": self.endDate + " " + self.endTime,
            "contact": self.contact,
            "location": self.location,
            "body": self.body,
            "imageUuid": self.imageUUID ?? self.basicImage,
        ]
        
        API.createEvent(parameter) {
            print("이벤트 생성 성공")
            completion()
        }
    }
    
    func loadEvent() {
        let manager = EventManager.shared
        
    }
}
