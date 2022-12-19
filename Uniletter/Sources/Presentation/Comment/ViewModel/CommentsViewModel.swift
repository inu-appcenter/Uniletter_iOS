//
//  CommentsViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/12.
//

import UIKit

final class CommentsViewModel {
    
    // MARK: - Property
    
    private var comments: [Comment] = []
    private var eventID: Int
    
    // MARK: - Init
    
    init(_ id: Int) {
        self.eventID = id
    }
    
    // MARK: - Output
    
    var numofComments: Int {
        return comments.count
    }
    
    func infoOfComment(_ index: Int) -> Comment {
        return comments[index]
    }
    
    // MARK: - Func
    
    func loadComments(completion: @escaping () -> Void) {
        API.getComments(eventID) { [weak self] comments in
            self?.comments = comments
            completion()
        }
    }
    
    func writeComments(_ text: String, completion: @escaping () -> Void) {
        API.createComment(data: ["eventId": eventID, "content": text]) {
            completion()
        }
    }
    
}
