//
//  NewNoticeViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/04.
//

import UIKit

class NewNoticeViewModel {
    
    let image: [UIImage] = [
                            UIImage(named: "Club")!,
                            UIImage(named: "StudentCountcil")!,
                            UIImage(named: "Sharing")!,
                            UIImage(named: "Competition")!,
                            UIImage(named: "Study")!,
                            UIImage(named: "Job")!,
                            UIImage(named: "Etc")!,
                            ]
    
    var title: [String] = [
                            "동아리/소모임",
                            "학생회",
                            "간식나눔",
                            "대회/공모전",
                            "스터디",
                            "구인",
                            "기타"
                            ]
    
    // 선택완료 누르면 서버로 보내고 받아와야함
    var selected: [Bool] = [
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            false,
                            ]
    
    var numOfCell: Int {
        return image.count
    }
    
    func imageOfIndex(_ index: Int) -> UIImage {
        return image[index]
    }
    
    func titleOfIndex(_ index: Int) -> String {
        return title[index]
    }
}
