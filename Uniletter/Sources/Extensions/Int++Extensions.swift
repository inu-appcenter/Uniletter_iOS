//
//  Int++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/10/04.
//

import Foundation

extension Int {
    
    /// 2자리 정수로 반환 ex) 일의 자리 = 03
    func formatNumbers() -> String {
        return String(format: "%02d", self)
    }
    
}
