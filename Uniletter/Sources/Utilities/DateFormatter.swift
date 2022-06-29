//
//  DateFormatter.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import Foundation

func subDateString(_ dateStr: String) -> String {
    return String(dateStr.prefix(10))
}

func formatStringToDate(_ dateStr: String) -> Date {
    let str = subDateString(dateStr)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    let date = dateFormatter.date(from: String(str)) ?? Date()
    
    return date
}

func caculateDDay(_ endAt: String) -> String {
    let endAt = formatStringToDate(endAt)
    let now = Date()
    let interval = endAt.timeIntervalSince(now)
    let dday = Int(interval / 86400) + 1
    
    return "\(dday)"
}
