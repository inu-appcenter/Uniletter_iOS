//
//  DateFormatter.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import Foundation

func caculateDDay(_ endAt: String) -> String {
    let str = endAt.prefix(10)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let endDate = dateFormatter.date(from: String(str)) ?? Date()
    let now = Date()
    let interval = endDate.timeIntervalSince(now)
    let dday = Int(interval / 86400) + 1
    
    return "\(dday)"
}
