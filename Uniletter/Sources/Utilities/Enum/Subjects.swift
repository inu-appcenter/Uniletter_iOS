//
//  Subjects.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/06.
//

import Foundation

enum Subjects {
    case title
    case host
    case category
    case start
    case end
    case target
    case contact
    case link
}

extension Subjects {
    
    var title: String {
        switch self {
        case .title, .host:
            return ""
        case .category:
            return "카테고리"
        case .start:
            return "시작일시"
        case .end:
            return "마감일시"
        case .target:
            return "모집대상"
        case .contact:
            return "문의사항"
        case .link:
            return "신청링크"
        }
    }
    
    var guideTitle: String {
        switch self {
        case .title:
            return "제목을 입력해주세요."
        case .host:
            return "소속된 단체를 입력해주세요."
        case .category:
            return "카테고리를 선택해주세요."
        case .start:
            return ""
        case .end:
            return ""
        case .target:
            return "모집대상을 입력해주세요."
        case .contact:
            return "문의사항시 연락방법을 입력해주세요."
        case .link:
            return "첨부할 URL이 있다면 입력해주세요."
        }
    }
    
}
