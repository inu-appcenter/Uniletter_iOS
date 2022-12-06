//
//  WritingSubFile.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/23.
//

import UIKit

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

// MARK: - 카테고리

enum BasicInfo: Int, CaseIterable {
    case none = 0        // 선택없음, 기타
    case group = 1       // 동아리, 소모임
    case council = 2     // 학생회
    case snacks = 3      // 간식나눔
    case contest = 4     // 대회, 공모전
    case study = 5       // 스터디
    case offer = 6       // 구인
    
    var uuid: String {
        switch self {
        case .none: return "1ec96f4e-970e-6780-792a-5dc26eec006c"
        case .group: return "1ec94c4d-284e-6b70-6eba-0ecc1b8dd491"
        case .council: return "1ec94c3f-2c9d-6590-1fd7-cb603aa85e1e"
        case .snacks: return "1ec94c15-ee15-6f30-8bdd-76769baf2a97"
        case .contest: return "1ec94c15-786e-6520-ea08-df4f8c716b04"
        case .study: return "1ec94c49-4fd6-6ca0-1497-d8b902900844"
        case .offer: return "1ec94c42-4e1a-6030-9859-6dc8e7afe7df"
        }
    }
    
    var image: UIImage {
        switch self {
        case .none: return UIImage(named: "Etc_p")!
        case .group: return UIImage(named: "Club_p")!
        case .council: return UIImage(named: "StudentCountcil_p")!
        case .snacks: return UIImage(named: "Sharing_p")!
        case .contest: return UIImage(named: "Competition_p")!
        case .study: return UIImage(named: "Study_p")!
        case .offer: return UIImage(named: "Job_p")!
        }
    }
}

// MARK: - 유효성 검사

enum WritingValidation {
    case success
    case title
    case target
    case both
}
