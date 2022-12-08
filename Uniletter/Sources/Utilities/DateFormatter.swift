//
//  DateFormatter.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/28.
//


import Foundation

/// 날짜, 시간 관련 기능을 담은 custom class
final class CustomFormatter {
    
    static func convertISO8601DateToString(
        _ dateStr: String,
        _ format: String,
        _ isMyEvent: Bool)
    -> String
    {
        let formatter = DateFormatter()
        let calendar = Calendar.current
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let date = formatter.date(from: dateStr)!
        let result = calendar.date(byAdding: .hour, value: 9, to: date)!
        
        formatter.dateFormat = format
        
        let diffYear = calendar.dateComponents([.year], from: result, to: Date()).year!
        if diffYear > 0 && isMyEvent {
            return "\(diffYear)년전"
        }
        
        return formatter.string(from: result)
    }
    
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

    /// 시간 AM, PM으로 변환
    static func convertTime(_ dateStr: String) -> String {
        let time = dateStr.count > 10 ? subTimeString(dateStr) : dateStr
        let minEOffset = dateStr.count > 10 ? time.count : 5
        let hour = Int(time.subStringByIndex(sOffset: 0, eOffset: 2))!
        let min = time.subStringByIndex(sOffset: 3, eOffset: minEOffset)
        
        if hour > 12 {
            return ("\((hour % 12).formatNumbers()):\(min) 오후")
        } else if hour == 12 {
            return ("\(hour):\(min) 오후")
        } else {
            return ("\(hour.formatNumbers()):\(min) 오전")
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
