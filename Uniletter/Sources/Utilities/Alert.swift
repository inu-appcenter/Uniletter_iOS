//
//  Alert.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import Foundation

enum Alert {
    case login
    case logout
    case report
    case blockOn
    case blockOff
    case delete
    case save
    case notification
    
    var title: String {
        switch self {
        case .login: return "로그인 하시겠습니까?"
        case .logout: return "로그아웃 하시겠습니까?"
        case .report: return "정말 신고 하시겠습니까?"
        case .blockOn: return "정말 차단 하시겠습니까?"
        case .blockOff: return "차단을 해제 하시겠습니까?"
        case .delete: return "정말 삭제 하시겠습니까?"
        case .save: return "저장을 취소 하시겠습니까?"
        case .notification: return "알림을 취소 하시겠습니까?"
        }
    }
}
