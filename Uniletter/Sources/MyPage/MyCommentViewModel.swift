//
//  MyCommentViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/08.
//

import UIKit


// 구조체
// 이벤트 사진, 이벤트 타이틀, 이벤트 바디, 이벤트 작성 날짜, 이벤트 댓글갯수

struct MyCommentList {
    var eventId: Int
    var eventUrl: String
    var eventTitle: String
    var eventBody: String
    var writeDay: String
    var commentCount: Int
}

class MyCommentViewModel {
    
    static let shared = MyCommentViewModel()
    
    var myComments = [myComment]()
    var events = [Event]()
    var CommentList = [MyCommentList]()
    
    var numOfCell: Int {
        return CommentList.count
    }
    
    func getMyComments(completion: @escaping () -> Void) {
        API.getMyComment { myComments in
            self.myComments = myComments
            completion()
        }
    }
    
    func setEventImage(imageUrl: String) -> UIImage {
        
        let url = URL(string: imageUrl)!

        guard let data = try? Data(contentsOf: url) else { return UIImage(named: "UserImage") ?? UIImage() }
        
        return UIImage(data: data)!
    }
    

    
}
