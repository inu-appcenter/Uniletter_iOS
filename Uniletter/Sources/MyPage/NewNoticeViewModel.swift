//
//  NewNoticeViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/04.
//

import UIKit

class NewNoticeViewModel {
    
    let item: [UIImage] = [
                            UIImage(named: "Club")!,
                            UIImage(named: "StudentCountcil")!,
                            UIImage(named: "Sharing")!,
                            UIImage(named: "Competition")!,
                            UIImage(named: "Study")!,
                            UIImage(named: "Job")!,
                            UIImage(named: "Etc")!,
                            ]
    
    var numOfCell: Int {
        return item.count
    }
    
    func itemOfIndex(_ index: Int) -> UIImage {
        return item[index]
    }
}
