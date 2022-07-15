//
//  BlockListViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import Foundation

class BlockListViewModel {
    
    var blocks = [Block]()
    
    var numOfCell: Int {
        return blocks.count
    }
    
    func getBlock(completion: @escaping() -> Void) {
        API.getBlock { result in
            self.blocks = result
            completion()
        }
    }
    
    func deleteBlock(index: Int, completion: @escaping() -> Void) {
        API.deleteBlock(data: ["targetUserId": self.blocks[index].user.id]) {
            completion()
        }
    }
    
    func postBlock() {
        API.postBlock(data: ["targetUserId": 54]) {
            print("성공")
        }
    }
}
