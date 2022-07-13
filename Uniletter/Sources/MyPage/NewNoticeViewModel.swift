//
//  NewNoticeViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/04.
//

import UIKit


enum Notice: CaseIterable {
    case club
    case studentCountcil
    case sharing
    case competition
    case study
    case job
    case etc
    
    var image: UIImage {
        switch self {
        case .club: return UIImage(named: "Club")!
        case .studentCountcil: return UIImage(named: "StudentCountcil")!
        case .sharing: return UIImage(named: "Sharing")!
        case .competition: return UIImage(named: "Competition")!
        case .study: return UIImage(named: "Study")!
        case .job: return UIImage(named: "Job")!
        case .etc: return UIImage(named: "Etc")!
        }
    }
    
    var title: String {
        switch self {
        case .club: return "동아리/소모임"
        case .studentCountcil: return "학생회"
        case .sharing: return "간식나눔"
        case .competition: return "대회/공모전"
        case .study: return "스터디"
        case .job: return "구인"
        case .etc: return "기타"
        }
    }
}
class NewNoticeViewModel {
    
    var topics: Topic?
    
    var notices: [Notice] = [.club, .studentCountcil, .sharing, .competition, .study, .job, .etc]
    
    var selected: [String: Bool] = [
                                    "동아리/소모임": false,
                                    "학생회": false,
                                    "간식나눔": false,
                                    "대회/공모전": false,
                                    "스터디": false,
                                    "구인": false,
                                    "기타": false,
                                    ]
    
    var numOfCell: Int {
        return notices.count
    }
    
    func imageOfIndex(_ index: Int) -> UIImage {
        return notices[index].image
    }
    
    func titleOfIndex(_ index: Int) -> String {
        return notices[index].title
    }
    
    func setTopic(completion: @escaping() -> Void) {
        API.getTopic { result in
            self.topics = result
            self.selectedTopics(topic: result)
            completion()
        }
    }
    
    func selectedTopics(topic: Topic) {
        for i in topic.topics {
            selected[i] = true
        }
    }
}
