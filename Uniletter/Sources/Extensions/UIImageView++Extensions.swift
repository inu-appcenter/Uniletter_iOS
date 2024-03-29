//
//  UIImageView++Extensions.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/22.
//

import UIKit
import SnapKit
import Kingfisher

enum ImageViewState {
    case detail
    case writing
    case preview
}

extension UIImageView {
    
    /// Dynamic imageView size
    func updateImageViewRatio(_ imgView: ImageViewState, _ constraint: CGFloat? = nil) {
        guard let image = self.image else {
            return
        }
        let ratio = image.size.width / image.size.height
        let height = self.frame.width / ratio
        
        switch imgView {
        case .detail:
            self.snp.makeConstraints {
                $0.height.equalTo(height)
            }
        case .writing:
            self.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(constraint!)
                $0.left.right.equalToSuperview().inset(20)
                $0.height.equalTo(height)
            }
        case .preview:
            self.snp.remakeConstraints {
                $0.top.equalToSuperview().offset(15)
                $0.left.right.equalToSuperview().inset(20)
                $0.height.equalTo(height)
            }
        }
    }
    
    func fetchImage(_ imgURL: String, _ width: CGFloat, _ height: CGFloat) {
        guard let url = URL(string: imgURL) else {
            return
        }
        let processor = DownsamplingImageProcessor(size: CGSize(width: width, height: height))
        
        kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .cacheMemoryOnly
            ])
    }
    
}
