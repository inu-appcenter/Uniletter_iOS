//
//  MyPageViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/06/30.
//

import UIKit

enum SectionType: CaseIterable {
    case setting
    case shortcut
    case infomation
    case etc
    
    var title: String {
        switch self {
        case .setting: return "설정"
        case .shortcut: return "바로가기"
        case .infomation: return "이용 안내"
        case .etc: return "로그아웃"
        }
    }
    
    var cell: [String] {
        switch self {
        case .setting: return ["새로운 행사 알림"]
        case .shortcut: return ["내가 쓴글", "댓글 단 글", "차단한 계정"]
        case .infomation: return ["개인정보 처리방침", "오픈소스 라이센스"]
        case .etc: return ["로그아웃"]
        }
    }
    
    var view: [UIViewController] {
        switch self {
        case .setting: return [NewNoticeViewController()]
        case .shortcut: return [UIViewController(), UIViewController(), UIViewController()]
        case .infomation: return [UIViewController(), UIViewController(), UIViewController()]
        case .etc: return [UIViewController()]
            
        }
    }
}

class MyPageViewModel {
    
    var type: [SectionType] = [.setting, .shortcut, .infomation, .etc]
    
    var numOfSection: Int {
        return type.count
    }
    
    func titleOfSection(at index: Int) -> String {
        return self.type[index].title
    }
    
    func numOfCell(at index: Int) -> Int {
        return self.type[index].cell.count
    }
    
    func viewOfSection(_ sectionIndex: Int, _ rowIndex: Int) -> UIViewController {
        return self.type[sectionIndex].view[rowIndex]
    }
}
