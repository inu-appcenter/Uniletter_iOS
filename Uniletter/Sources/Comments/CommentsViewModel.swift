//
//  CommentsViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/12.
//

import UIKit

class CommentsViewModel {
    
    // MARK: - Property
    var comments = [Comment]()
    var eventID: Int?
    
    // MARK: - UI
    var numofComments: Int {
        return comments.count
    }
    
    func infoOfComment(_ index: Int) -> Comment {
        return comments[index]
    }
    
    // MARK: - Write comments
    func writeComments(_ text: String, completion: @escaping () -> Void) {
        guard let eventID = eventID else { return }

        API.createComment(data: ["eventId": eventID, "content": text]) {
            completion()
        }
    }
    
    
    // MARK: - Load data
    func loadComments(_ id: Int, completion: @escaping () -> Void) {
        API.getComments(id) { comments in
            self.comments = comments
            completion()
        }
    }
}
