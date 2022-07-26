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
        case .shortcut: return ["내가 쓴 글", "댓글 단 글", "차단한 계정"]
        case .infomation: return ["개인정보 처리방침", "오픈소스 라이센스"]
        case .etc: return ["로그아웃"]
        }
    }
    
    var view: [UIViewController] {
        switch self {
        case .setting: return [NewNoticeViewController()]
        case .shortcut: return [MyEventViewController(), MyCommentViewController(), BlockListViewController()]
        case .infomation: return [PrivacyPolicyViewController(), LicenseViewController()]
        case .etc: return [UIViewController()]
        }
    }
}

class MyPageManager {
    
    static let shared = MyPageManager()
    
    private init() { }
    
    var me: Me?
    
    var type: [SectionType] = [.setting, .shortcut, .infomation, .etc]
    
    var userName: String?
    var userImageUrl: String?
    var userImage: UIImage?
    var choiceImage: UIImage?
    var changeName: String?
    
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
    
    func setUserInfo(completion: @escaping () -> Void) {
        API.getMeInfo { Me in
            self.me = Me
            completion()
        }
    }

    func setUserImage() -> UIImage {
        
        guard let imageUrl = me?.imageUrl else {
            self.userImage = UIImage(named: "UserImage")
            return UIImage(named: "UserImage") ?? UIImage()
        }
        
        let url = URL(string: imageUrl)!

        guard let data = try? Data(contentsOf: url) else { return UIImage(named: "UserImage") ?? UIImage()
        }
        
        userImage = UIImage(data: data)!
        return UIImage(data: data)!
    }
    
    func setUserNickName() -> String {
        guard let nickname = me?.nickname else { return "사용자"}
        
        userName = nickname
        
        return nickname
    }
}
