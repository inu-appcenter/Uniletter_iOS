//
//  Address.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

enum Address {
    case block              // 차단
    case comments           // 댓글
    case mycomments         // 내 댓글
    case push               // [테스트] 푸시알림
    case events             // 행사
    case eventscommented    // 내가 댓글 단 행사
    case myevents           // 내가 쓴 행사
    case token              // FCM 토큰
    case images             // 이미지
    case likes              // 북마크
    case loginOauth         // OAuth 로그인
    case loginRemembered    // OAuth 로그인
    case nofifications      // 행사 알림
    case subscribing        // 새 행사 구독 여부
    case topics             // 새 행사 구독 토픽
    case me                 // 내 정보
    case users              // 사용자
    
    var url: String {
        switch self {
        case .block: return "blocks"
        case .comments: return "comments"   // + commentId
        case .mycomments: return "mycomments"
        case .push: return "push"
        case .events: return "events"   // + eventId
        case .eventscommented: return "events-ive-commented"
        case .myevents: return "myevents"
        case .token: return "fcm/token"
        case .images: return "images"   // + imageId
        case .likes: return "likes"
        case .loginOauth: return "login/oauth"
        case .loginRemembered: return "login/remembered"
        case .nofifications: return "notifications"
        case .subscribing: return "subscription/subscribing"
        case .topics: return "subscription/topics"
        case .me: return "me"
        case .users: return "users/"    // +id
        }
    }
}
