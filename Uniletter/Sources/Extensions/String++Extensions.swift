//
//  String++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/09/17.
//

import Foundation

extension String {
    
    /// 인덱스 받아서 슬라이싱
    func subStringByIndex(sOffset: Int, eOffset: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: sOffset)
        let end = self.index(self.startIndex, offsetBy: eOffset)
        let range = start..<end
        
        return String(self[range])
    }
    
}
