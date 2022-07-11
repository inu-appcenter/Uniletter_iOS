//
//  CommentsViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/12.
//

import UIKit

class CommentsViewModel {
    
    // MARK: - Property
    let comments = [Comment]()
    
    // MARK: - UI
    var numofComments: Int {
        return comments.count
    }
    
    func infoOfComment(_ index: Int) -> Comment {
        return comments[index]
    }
    
    // MARK: - Write comments
    
    
    // MARK: - Load data
    func loadComments(completion: @escaping () -> Void) {
        
    }
}
