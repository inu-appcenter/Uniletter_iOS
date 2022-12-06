//
//  ActionSheet.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/04.
//

import Foundation

enum ActionSheet {
    case topForUser
    case topForWriter
    case profile
    case notification
    case commentForUser
    case commentForWriter
    case modifyInfo
    
    var title: String {
        switch self {
        case .topForUser, .topForWriter: return "글 메뉴"
        case .profile: return "사용자 메뉴"
        case .notification: return "알림 신청"
        case .commentForUser, .commentForWriter: return "댓글 메뉴"
        case .modifyInfo: return "프로필 사진 설정"
        }
    }
    
    var buttonText: [String] {
        switch self {
        case .topForUser: return ["신고하기"]
        case .topForWriter: return ["수정하기", "삭제하기"]
        case .profile: return ["차단하기"]
        case .notification: return ["시작 전 알림", "마감 전 알림"]
        case .commentForUser: return ["신고하기", "사용자 차단하기"]
        case .commentForWriter: return ["삭제"]
        case .modifyInfo: return ["앨범에서 사진 선택", "기본 이미지로 변경"]
        }
    }
}
