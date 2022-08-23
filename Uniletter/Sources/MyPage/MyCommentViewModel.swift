//
//  MyCommentViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/08.
//

import UIKit

class MyCommentViewModel {
    
    var myComments = [Comment]()
    var events = [Event]()
    var eventIdList = [Int]()

    var numOfCell: Int {
        return events.count
    }
    
    func getMyComments(completion: @escaping() -> Void) {
        
        let firstDispatchGroup = DispatchGroup()
        let secondDispatchdGroup = DispatchGroup()
        
        events = [Event]()
        
        firstDispatchGroup.enter()
        
        API.getMyComment { result in
            print(result)
            self.myComments = result
            self.returnEventIdList(CommentList: self.myComments)
            firstDispatchGroup.leave()
        }
        
        firstDispatchGroup.notify(queue: .main) {
            
            for i in self.eventIdList {
                
            secondDispatchdGroup.enter()
    
            API.getEventOne(i) { Event in
                self.events.append(Event)
                self.sortedEventList(event: self.events)
                secondDispatchdGroup.leave()
                }
            }
            
            secondDispatchdGroup.notify(queue: .main) {
                completion()
            }
        }
    }
    
    func setEventImage(imageUrl: String) -> UIImage {
        
        let url = URL(string: imageUrl)!

        guard let data = try? Data(contentsOf: url) else { return UIImage(named: "UserImage") ?? UIImage() }
        
        return UIImage(data: data)!
    }
    

    func returnEventIdList(CommentList: [Comment]) {

        var eventIdList = [Int]()
        
        if CommentList.count >= 1{
            for i in 0...CommentList.count - 1 {
                if eventIdList.isEmpty == true {
                    eventIdList.append(CommentList[i].eventID)
                } else {
                    if eventIdList.contains(CommentList[i].eventID) == false {
                        eventIdList.append(CommentList[i].eventID)
                    }
                }
            }
            self.eventIdList = eventIdList
        } else {
            self.eventIdList = []
        }
    }
    
    func sortedEventList(event: [Event]) {
        
        self.events = self.events.sorted(by: { $0.id > $1.id} )
    }
}
