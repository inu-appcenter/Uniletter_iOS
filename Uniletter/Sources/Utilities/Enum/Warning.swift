//
//  Warning.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/20.
//
import Foundation

enum Warning {
    case none
    case comment
    case writing
    case login
    case loginWriting
    case loginLike
    case loginComment
    case loginBlock
    case loginNoti
    case loginReport
    case loginRemembered
    case reportEvent
    case reportComment
    case logout
    case blockUser
    case cancleBlock
    case cancleSave
    case cancleAlarm
    case deleteComment
    case deleteEvent
    case changeEvent
    case createEvent
    case deleteAccount
    
    var body: String {
        switch self {
        case .none, .loginRemembered:
            return ""
        case .comment:
            return "댓글은 300자 이내로 입력가능합니다."
        case .writing:
            return "필수정보를 모두 입력해주세요."
        case .login:
            return "로그인 성공! 유니레터에 오신 것을 환영합니다."
        case .loginWriting:
            return "로그인을 하셔야 게시글 작성이 가능합니다."
        case .loginLike:
            return "로그인을 하셔야 저장하실 수 있습니다."
        case .loginComment:
            return "로그인을 하셔야 댓글 작성이 가능합니다."
        case .loginBlock:
            return "로그인을 하셔야 사용자 차단이 가능합니다."
        case .loginNoti:
            return "로그인을 하셔야 알림을 받으실 수 있습니다."
        case .loginReport:
            return "로그인을 하셔야 신고를 하실 수 있습니다."
        case .reportEvent:
            return "게시글이 신고되었습니다."
        case .reportComment:
            return "댓글이 신고되었습니다."
        case .logout:
            return "로그아웃되었습니다."
        case .blockUser:
            return "해당 사용자가 차단되었습니다."
        case .cancleBlock:
            return "차단이 해제되었습니다."
        case .cancleSave:
            return "저장이 취소되었습니다."
        case .cancleAlarm:
            return "알림이 취소되었습니다."
        case .deleteComment:
            return "댓글이 삭제되었습니다."
        case .deleteEvent:
            return "게시글이 삭제되었습니다."
        case .changeEvent:
            return "게시글이 수정되었습니다."
        case .createEvent:
            return "게시글이 작성되었습니다."
        case .deleteAccount:
            return "회원탈퇴가 완료되었습니다."
        }
    }
}
