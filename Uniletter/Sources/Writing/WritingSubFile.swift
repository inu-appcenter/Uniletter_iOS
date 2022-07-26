//
//  WritingSubFile.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import Foundation

// MARK: 행사 시작, 마감 종류 구별
enum Style {
    case start
    case end
}

// MARK: 행사 날짜 및 시간 선택 delegate
protocol TimeSetDelegate {
    func setTime(time: String, style: Style)
}

protocol DateSetDelegate {
    func setDate(date: String, style: Style)
}


