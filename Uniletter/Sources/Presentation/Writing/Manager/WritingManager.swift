//
//  WritingManager.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/18.
//

import UIKit
import CoreData

final class WritingManager {
    
    static let shared = WritingManager()
    
    // MARK: - Init
    
    private init() { }
    
    // MARK: - Property
    
    private var basicImage = BasicInfo.etc.uuid
    var mainImage = BasicInfo.etc.image
    var id: Int?
    var imageIndex = 6
    var imageType: ImageType = .basic
    var imageURL: String?
    var title: String?
    var host = "" {
        didSet { host = host == hostPlaceholder ? "" : host }
    }
    var category = "기타"
    var target: String?
    var contact = ""
    var location = ""
    var body = ""
    var imageUUID: String?
    var startDate = CustomFormatter.convertTodayToString(true)
    var startTime = CustomFormatter.convertNowTime(false)
    var endDate = CustomFormatter.convertTodayToString(true)
    var endTime = CustomFormatter.convertNowTime(false)
    
    let categories = ["동아리/소모임", "학생회", "간식나눔", "대회/공모전", "스터디", "구인", "기타"]
    let hostPlaceholder = "ex)총학생회, 디자인학부"
    let contanctPlaceholder = "ex)010-1234-5678 / uniletter@gmail.com"
    let detailPlaceholder = "하위 게시물이나 부적절한 언어 사용 시\n유니레터 이용이 어려울 수 있습니다."
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EventModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("실패요")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    var reloadCount: Int {
        do {
            let count = try self.context.count(for: SavedEvent.fetchRequest())
            return count
        } catch {
            return 0
        }
    }
    
    // MARK: - Output
    
    var index: Int {
        return categories.firstIndex(of: category)!
    }
    
    // MARK: - Func
    
    private func setBasicImage() {
        switch self.imageIndex {
        case 0: changeImage(.group)
        case 1: changeImage(.council)
        case 2: changeImage(.snacks)
        case 3: changeImage(.contest)
        case 4: changeImage(.study)
        case 5: changeImage(.offer)
        case 6: changeImage(.etc)
        default: break
        }
    }
    
    private func changeImage(_ basic : BasicInfo) {
        if imageType == .basic {
            mainImage = basic.image
            imageUUID = basic.uuid
        }
    }
    
    func removeData() {
        id = nil
        basicImage = BasicInfo.etc.uuid
        imageType = .basic
        imageIndex = 6
        mainImage = BasicInfo.etc.image
        title = nil
        host = ""
        category = "기타"
        target = nil
        contact = ""
        location = ""
        body = ""
        imageUUID = nil
        startDate = CustomFormatter.convertTodayToString(true)
        startTime = CustomFormatter.convertNowTime(false)
        endDate = CustomFormatter.convertTodayToString(true)
        endTime = CustomFormatter.convertNowTime(false)
    }
    
    func isUpdating() -> Bool {
        return id == nil ? false : true
    }
    
    func setImage(_ image: UIImage) {
        self.mainImage = image
        self.imageType = .custom
        
        API.uploadMeImage(image: image) { result in
            self.imageUUID = result.uuid
        }
    }
    
    func equalDateTime() {
        endDate = startDate
        endTime = startTime
    }
    
    func checkEventInfo() -> WritingValidation {
        if title == nil || title == "" {
            return (target == nil || target == "") ? .both : .title
        } else {
            return (target == nil || target == "") ? .target : .success
        }
    }
    
    func showPreview() -> Preview {
        setBasicImage()
        
        let preview = Preview(
            mainImage: mainImage,
            imageType: imageType,
            imageUUID: imageUUID ?? basicImage,
            title: title!,
            host: host,
            category: category,
            target: target!,
            startAt: startDate + "T" + startTime + ".000+09:00",
            endAt: endDate + "T" + endTime + ".000+09:00",
            contact: contact,
            location: location,
            body: body)
        
        return preview
    }
    
    func loadEvent(_ event: Event) {
        title = event.title
        host = event.host ?? ""
        category = event.category
        target = event.target
        startDate = CustomFormatter.subDateString(event.startAt)
        startTime = CustomFormatter.subTimeString(event.startAt) + ":00"
        endDate = CustomFormatter.subDateString(event.endAt)
        endTime = CustomFormatter.subTimeString(event.endAt) + ":00"
        contact = event.contact ?? ""
        location = event.location ?? ""
        body = event.body
        imageUUID = event.imageUUID
        imageURL = event.imageURL
        id = event.id
        imageType = .custom
        
        BasicInfo.allCases.forEach {
            if $0.uuid == event.imageUUID {
                imageIndex = $0.rawValue
                imageType = .basic
            }
        }
    }
    
    func loadEventFromSave(_ event: SavedEvent) {
        title = event.title
        host = event.host!
        category = event.category!
        target = event.target
        startDate = event.startDate!
        startTime = event.startTime!
        endDate = event.endDate!
        endTime = event.endTime!
        contact = event.concat!
        location = event.location!
        body = event.body!
        
        if let imageUUID = event.imageUUID {
            imageURL = baseURL + Address.images.url + "/" + imageUUID
            self.imageUUID = imageUUID
        } else {
            imageUUID = ""
            imageURL = ""
        }
        
        imageType = .custom
    
        BasicInfo.allCases.forEach {
            if $0.uuid == event.imageUUID {
                imageIndex = $0.rawValue
                imageType = .basic
            }
        }
        
    }
    
    func saveEvent() {
        let entity = NSEntityDescription.entity(forEntityName: "SavedEvent", in: context)
        
        if let entity = entity {
            let save = NSManagedObject(entity: entity, insertInto: context)
            save.setValue(self.category, forKey: "category")
            save.setValue(self.contact, forKey: "concat")
            save.setValue(self.endDate, forKey: "endDate")
            save.setValue(self.endTime, forKey: "endTime")
            save.setValue(self.host, forKey: "host")
            save.setValue(self.location, forKey: "location")
            save.setValue(self.startDate, forKey: "startDate")
            save.setValue(self.startTime, forKey: "startTime")
            save.setValue(self.target, forKey: "target")
            save.setValue(self.title, forKey: "title")
            save.setValue(self.imageURL, forKey: "imageURL")
            save.setValue(self.imageUUID, forKey: "imageUUID")
            save.setValue(self.body, forKey: "body")
            save.setValue(CustomFormatter.nowTimeToString(), forKey: "saveDate")
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchEvent() -> [SavedEvent] {
        do {
            let events = try self.context.fetch(SavedEvent.fetchRequest())
            return events
        } catch {
            print("임시 저장 목록 가져오기 실패")
            return []
        }
    }
    
    func deleteEvent(_ event: SavedEvent) {
        self.context.delete(event)
        
        do {
            try self.context.save()
        } catch {
            print("해당 임시 저장 삭제 실패")
        }
    }
    
    // MARK: - Networking
    
    private func createParameter() -> [String: String] {
        return [
            "title": title!,
            "host": host,
            "category": category,
            "target": target!,
            "startAt": startDate + " " + startTime,
            "endAt": endDate + " " + endTime,
            "contact": contact,
            "location": location,
            "body": body,
            "imageUuid": imageUUID ?? basicImage,
        ]
    }
    
    func createEvent(completion: @escaping () -> Void) {
        API.createEvent(createParameter()) {
            print("이벤트 생성 성공")
            completion()
        }
    }
    
    func updateEvent(completion: @escaping () -> Void) {
        guard let id = id else {
            return
        }

        API.updateEvent(id: id, params: createParameter()) {
            print("이벤트 수정 성공")
            completion()
        }
    }
    
    
}
