//
//  DateFormatter.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//

import Foundation

/// 받아온 날짜 년-월-일 구하기
func subDateString(_ dateStr: String) -> String {
    return String(dateStr.prefix(10))
}

/// 받아온 날짜 시간:분 구하기
func subTimeString(_ dateStr: String) -> String {
    let start = dateStr.index(dateStr.startIndex, offsetBy: 11)
    let end = dateStr.index(dateStr.startIndex, offsetBy: 16)
    let range = start..<end
    
    return String(dateStr[range])
}

/// 받아온 날짜 년.월.일 시간:분 구하기(댓글용)
func formatDateForComments(_ dateStr: String) -> String {
    let start = dateStr.index(dateStr.startIndex, offsetBy: 2)
    let end = dateStr.index(dateStr.startIndex, offsetBy: 10)
    let range = start..<end
    let date = String(dateStr[range]).replacingOccurrences(of: "-", with: ".")
    let time = subTimeString(dateStr)
    
    return "\(date) \(time)"
}

/// 시간 AM, PM으로 변환
func convertTime(_ dateStr: String) -> String {
    let time = subTimeString(dateStr)
    
    var start = time.startIndex
    var end = time.index(time.startIndex, offsetBy: 2)
    var range = start..<end
    let hour = String(time[range])
    
    start = time.index(time.startIndex, offsetBy: 3)
    end = time.endIndex
    range = start..<end
    let min = String(time[range])
    
    let int = Int(hour)!
    if int > 12 {
        return ("\(int % 12):\(min) PM")
    } else {
        return ("\(int):\(min) AM")
    }
}

/// 받아온 날짜 String -> Date로 변환
func formatStringToDate(_ dateStr: String) -> Date {
    let str = subDateString(dateStr)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"

    let date = dateFormatter.date(from: String(str)) ?? Date()
    
    return date
}

/// D-day 계산
func caculateDDay(_ endAt: String) -> String {
    let endAt = formatStringToDate(endAt)
    let now = Date()
    let interval = endAt.timeIntervalSince(now)
    let dday = Int(interval / 86400) + 1
    
    return "\(dday)"
}

/// 현재 날짜 String으로 반환
func convertTodayToString() -> String {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MMdd"
    
    return dateFormatter.string(from: now)
}

func StringToYearMonthDay(_ dataStr: String) -> [String] {
    let YearMonthDay = dataStr.components(separatedBy: "-")
    
    return YearMonthDay
}

func caculateWriteDay(_ dateStr: String) -> String {
    
    let date = subDateString(dateStr)
    
    let YearMonthDay =  date.components(separatedBy: "-")
    
    let month = YearMonthDay[1]
    let day = YearMonthDay[2]
    
    let writeDay = formatStringToDate(dateStr)
    let now = Date()
    
    let interval = now.timeIntervalSince(writeDay)
    
    if interval / 86400 > 365 {
        return "\(interval / 31536000)년전"
    } else {
        return "\(month)/\(day)"
    }
}
