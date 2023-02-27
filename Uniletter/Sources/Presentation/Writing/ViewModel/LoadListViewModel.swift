//
//  LoadListViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2023/02/26.
//

import Foundation

class LoadListViewModel {
    
    var writingManager = WritingManager.shared
    
    var loadList: [SavedEvent] {
        return writingManager.fetchEvent()
    }
    
    var numOfCell: Int {
        return loadList.count
    }
    
    func eventForIndex(_ index: Int) -> SavedEvent {
        return loadList[index]
    }
    
    func deleteEventForIndex(_ index: Int) {
        writingManager.deleteEvent(loadList[index])
    }
}
