//
//  String++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/09/17.
//

import UIKit

extension String {
    
    /// 인덱스 받아서 슬라이싱
    func subStringByIndex(sOffset: Int, eOffset: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: sOffset)
        let end = self.index(self.startIndex, offsetBy: eOffset)
        let range = start..<end
        
        return String(self[range])
    }
    
    func caculateDateDiff() -> [Int] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.locale = Locale(identifier: "ko")
        
        let date = formatter.date(from: self)!
        let time = Int(date.timeIntervalSinceNow)
        
        let calendar = Calendar.current
        let diff = calendar.dateComponents(
            [.day],
            from: calendar.startOfDay(for: Date()),
            to: calendar.startOfDay(for: date))
            .day!
        
        return [diff, time]
    }
    
    func validateHyperLink() -> Bool {
        return self.contains("http") || self.contains("bit")
    }
    
    func convertToHyperLink() -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        if validateHyperLink() {
            attributedString.addAttribute(
                .link,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: self.count))
        }
        
        return attributedString
    }
    
    func changeCategoryAttributed() -> NSAttributedString {
        return NSAttributedString(
            string: self,
            attributes: [
                .font: UIFont.systemFont(ofSize: 11, weight: .medium),
                .foregroundColor: UIColor.black
            ])
    }
    
}
