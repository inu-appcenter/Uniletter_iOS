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

enum NoticeAlert {
    case login
    case notice
    case startNotice
    case deadlineNotice
    case deleteNotice
    case block
    case deleteAccountFirst
    case deleteAccountSecond
    
    var title: String {
        switch self {
        case .login: return "로그인 알림"
        case .notice: return "알림 기준"
        case .startNotice: return "시작 전 알림신청"
        case .deadlineNotice: return "마감 전 알림신청"
        case .deleteNotice: return "알림취소"
        case .block: return "정지 알림"
        case .deleteAccountFirst: return "회원 탈퇴"
        case .deleteAccountSecond: return "회원 탈퇴"
        }
    }
    
    var body: String {
        switch self {
        case .login: return "로그인이 필요한 서비스입니다 :)"
        case .notice: return "유니레터의 두가지 알림 기준입니다\n\n시작 전 알림 : 행사 시작 5분전에 알림\n마감 전 알림: 행사 마감 하루전에 알림"
        case .startNotice: return "시작 전 알림 신청이 완료 되었습니다\n행사 5분전에 알림 드릴게요 :)"
        case .deadlineNotice: return "마감 전 알림 신청이 완료 되었습니다\n마감 하루전에 알림 드릴게요 :)"
        case .deleteNotice: return "알림을 정말 취소하시겠어요?\nㅠ0ㅠ"
        case .block: return "사용자 다수의 신고로\n 글작성과 댓글작성이 정지되었습니다."
        case .deleteAccountFirst: return "\n회원 탈퇴를 하시겠습니까?\n"
        case .deleteAccountSecond: return "회원 탈퇴시 작성한 글과 댓글 등의 정보는 \n완전히 삭제되며 복구가 불가능합니다.\n정말로 회원 탈퇴를 하시겠습니까? "
        }
    }
}
