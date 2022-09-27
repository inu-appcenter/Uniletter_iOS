//
//  DateFormatter.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//


import Foundation

/// 날짜, 시간 관련 기능을 담은 custom class
final class CustomFormatter {
    
    static func dateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }

    /// 받아온 날짜 년-월-일 구하기
    static func subDateString(_ dateStr: String) -> String {
        return String(dateStr.prefix(10))
    }

    /// 받아온 날짜 시간:분 구하기
    static func subTimeString(_ dateStr: String) -> String {
        return dateStr.subStringByIndex(sOffset: 11, eOffset: 16)
    }

    static func subTimeForTimePicker(_ time: String) -> [Int] {
        let hour = Int(time.prefix(2))!
        let min = Int(time.subStringByIndex(sOffset: 3, eOffset: 5))!
        
        return [hour, min]
    }

    /// 받아온 날짜 년.월.일 시간:분 구하기(댓글용)
    static func formatDateForComments(_ dateStr: String) -> String {
        let date = dateStr.subStringByIndex(sOffset: 2, eOffset: 10)
            .replacingOccurrences(of: "-", with: ".")
        let time = subTimeString(dateStr)
        
        return "\(date) \(time)"
    }

    /// 시간 AM, PM으로 변환
    static func convertTime(_ dateStr: String) -> String {
        let time = subTimeString(dateStr)
        let hour = time.subStringByIndex(sOffset: 0, eOffset: 2)
        let min = time.subStringByIndex(sOffset: 3, eOffset: time.count)
        
        let int = Int(hour)!
        if int > 12 {
            return (" - \(int % 12):\(min) 오후")
        } else {
            return (" - \(int):\(min) 오전")
        }
    }

    /// 받아온 날짜 String -> Date로 변환
    static func formatStringToDate(_ dateStr: String) -> Date {
        let str = subDateString(dateStr)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"

        let date = dateFormatter.date(from: String(str)) ?? Date()
        
        return date
    }

    /// D-day 계산
    static func caculateDDay(_ endAt: String) -> String {
        let endAt = formatStringToDate(endAt)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let interval = endAt.timeIntervalSinceNow
        let dday = Int(interval / 3600)
        
        return "\(dday)"
    }

    /// 현재 날짜 형식 맞춰 반환
    static func convertTodayToString(_ isDefault: Bool) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = isDefault ? "yyyy-MM-dd" : "yyyy.MM.dd"
        
        return dateFormatter.string(from: Date())
    }
    
    /// 현재 시간
    static func convertNowTime(_ isButton: Bool) -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = isButton ? "hh:mm a" : "HH:mm:00"
        
        return dateformatter.string(from: Date())
    }
    
    /// 글쓴 날짜 형식 맞춰 반환
    static func caculateWriteDay(_ dateStr: String) -> String {
        let date = subDateString(dateStr).components(separatedBy: "-")
        let month = date[1]
        let day = date[2]
        
        let writeDay = formatStringToDate(dateStr)
        let now = Date()
        
        let interval = now.timeIntervalSince(writeDay)
        
        if interval / 86400 > 365 {
            return "\(interval / 31536000)년전"
        } else {
            return "\(month)/\(day)"
        }
    }
    
}
