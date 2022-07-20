//
//  Warning.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/20.
//

import Foundation

enum Warning {
    case comment
    case writing
    case login
    case loginWriting
    case loginLike
    case loginComment
    case loginBlock
    case loginNoti
    
    var body: String {
        switch self {
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
        }
    }
}
