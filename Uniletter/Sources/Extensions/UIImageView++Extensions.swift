//
//  UIImageView++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/22.
//

import UIKit
import SnapKit

extension UIImageView {
    
    func updateImageViewRatio(_ isDetail: Bool) {
        guard let image = self.image else {
            return
        }
        let ratio = image.size.width / image.size.height
        let height = self.frame.width / ratio
        
        print(image.size)
        print(self.frame.size)
        
        if isDetail {
            self.snp.makeConstraints {
                $0.height.equalTo(height)
            }
        } else {
            self.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(15)
                $0.left.right.equalToSuperview().inset(20)
                $0.height.equalTo(height)
            }
        }
        
    }
    
}
