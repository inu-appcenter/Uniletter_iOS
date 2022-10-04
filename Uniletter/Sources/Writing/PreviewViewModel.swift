//
//  PreviewViewModel.swift
//  Uniletter
//
//  Created by 권오준 on 2022/09/27.
//

import Foundation

final class PreviewViewModel {
    
    // MARK: - Property
    
    var preview: Preview!
    
    // MARK: - UI
    
    var title: String {
        return self.preview.title
    }
    
    var category: String {
        return self.preview.category
    }
    
    var startAt: String {
        return self.convertTime(true)
    }
    
    var endAt: String {
        return self.convertTime(false)
    }
    
    var dday: String {
        return self.preview.endAt
    }
    
    var target: String {
        return self.preview.target
    }
    
    var contact: String {
        return self.preview.contact
    }
    
    var body: String {
        return self.preview.body
    }
    
    // MARK: - Func
    
    func convertTime(_ isStart: Bool) -> String {
        let date = isStart
        ? CustomFormatter.subDateString(self.preview.startAt)
        : CustomFormatter.subDateString(self.preview.endAt)
        let time = isStart
        ? CustomFormatter.convertTime(self.preview.startAt)
        : CustomFormatter.convertTime(self.preview.endAt)
        
        return date + time
    }
}
