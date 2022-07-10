//
//  MyCommentViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/08.
//

import UIKit

class MyCommentViewModel {
        
    var myComments = [myComment]()
    var events = [Event]()
    var eventIdList = [Int]()
    
    var numOfCell: Int {
        return events.count
    }
    
    func getMyComments(completion: @escaping () -> Void) {
        
        events = [Event]()
        
        API.getMyComment { result in
            self.myComments = result
            
            self.returnEventIdList(CommentList: self.myComments)
            
            for i in self.eventIdList {
                API.getEventOne(i) { Event in
                self.events.append(Event)
                self.sortedEventList(event: self.events)
                completion()
                }
            }
        }
    }
    
    func setEventImage(imageUrl: String) -> UIImage {
        
        let url = URL(string: imageUrl)!

        guard let data = try? Data(contentsOf: url) else { return UIImage(named: "UserImage") ?? UIImage() }
        
        return UIImage(data: data)!
    }
    
    
    func returnEventIdList(CommentList: [myComment]) {
        
        var eventIdList = [Int]()
        
        for i in 0...CommentList.count - 1 {
            if eventIdList.isEmpty == true {
                eventIdList.append(CommentList[i].eventId)
            } else {
                if eventIdList.contains(CommentList[i].eventId) == false {
                    eventIdList.append(CommentList[i].eventId)
                }
            }
        }
        
        self.eventIdList = eventIdList
    }
    
    func sortedEventList(event: [Event]) {
        
        self.events = self.events.sorted(by: { $0.id > $1.id} )
    }
}
