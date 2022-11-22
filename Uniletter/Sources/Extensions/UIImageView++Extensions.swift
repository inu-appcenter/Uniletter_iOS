//
//  UIImageView++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/22.
//

import UIKit
import SnapKit

extension UIImageView {
    
    func updateImageViewRatio() {
        guard let image = self.image else {
            return
        }
        let ratio = image.size.width / image.size.height
        let height = self.frame.width / ratio
        
        self.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }
    
}
