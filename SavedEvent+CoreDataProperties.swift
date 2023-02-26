//
//  SavedEvent+CoreDataProperties.swift
//  Uniletter
//
//  Created by 임현규 on 2023/02/26.
//
//

import Foundation
import CoreData


extension SavedEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedEvent> {
        return NSFetchRequest<SavedEvent>(entityName: "SavedEvent")
    }

    @NSManaged public var title: String?
    @NSManaged public var host: String?
    @NSManaged public var category: String?
    @NSManaged public var target: String?
    @NSManaged public var startDate: String?
    @NSManaged public var startTime: String?
    @NSManaged public var endDate: String?
    @NSManaged public var endTime: String?
    @NSManaged public var concat: String?
    @NSManaged public var location: String?
    @NSManaged public var image: Data?
    @NSManaged public var imageUUID: String?
    @NSManaged public var imageURL: String?

}

extension SavedEvent : Identifiable {

}
