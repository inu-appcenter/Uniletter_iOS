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
    case write
    case save
    case notification
    case load
    
    var title: String {
        switch self {
        case .login: return "로그인 하시겠습니까?"
        case .logout: return "로그아웃 하시겠습니까?"
        case .report: return "정말 신고 하시겠습니까?"
        case .blockOn: return "정말 차단 하시겠습니까?"
        case .blockOff: return "차단을 해제 하시겠습니까?"
        case .delete: return "정말 삭제 하시겠습니까?"
        case .write: return "정말 작성 하시겠습니까?"
        case .save: return "저장을 취소 하시겠습니까?"
        case .notification: return "알림을 취소 하시겠습니까?"
        case .load: return "선택한 임시글을 삭제하시겠습니까?"
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
    case pushAlarm
    case networkingFail
    case uploadImage
    case loadEvent
    case saveEvent
    
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
        case .pushAlarm: return "새로운 행사 알림"
        case .uploadImage: return "용량 초과 오류"
        case .networkingFail: return "네트워크 오류"
        case .loadEvent: return "임시 저장"
        case .saveEvent: return "임시 저장"
        }
    }
    
    var body: String {
        switch self {
        case .login: return "로그인이 필요한 서비스입니다 :)"
        case .notice: return "유니레터의 두가지 알림 기준입니다\n\n시작 전 알림: 행사 시작 5분전에 알림\n마감 전 알림: 행사 마감 하루전에 알림"
        case .startNotice: return "시작 전 알림 신청이 완료 되었습니다\n행사 5분전에 알림 드릴게요 :)"
        case .deadlineNotice: return "마감 전 알림 신청이 완료 되었습니다\n마감 하루전에 알림 드릴게요 :)"
        case .deleteNotice: return "알림이 취소 되었습니다\nㅠ0ㅠ"
        case .block: return "사용자 다수의 신고로\n 글작성과 댓글작성이 정지되었습니다."
        case .deleteAccountFirst: return "회원 탈퇴를 하시겠습니까?"
        case .deleteAccountSecond: return "회원 탈퇴시 작성한 글과 댓글 등의 정보는\n완전히 삭제되며 복구가 불가능합니다.\n정말로 회원 탈퇴를 하시겠습니까? "
        case .pushAlarm: return "알림 허용이 차단되어 있습니다.\n새로운 행사 알림을 받으시려면 알림 허용을 해주세요"
        case .uploadImage: return "8MB 이하의 사진만 첨부할 수 있습니다."
        case .networkingFail: return "네트워크 연결 상태가 좋지 않거나,\n네트워킹에 실패하였습니다.\n다시 시도해주세요."
        case .loadEvent: return "임시글을 불러오면\n작성 중인 글은 사라집니다.\n선택한 글을 불러오시겠습니까?"
        case .saveEvent: return "임시 저장이 완료되었습니다.\n저장된 글은 해당 기기에서만 이어서 작성가능합니다."
        }
    }
}
