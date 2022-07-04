//
//  UIImage++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit

extension UIImage {
    func resizeImage(width: CGFloat, height: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        self.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
