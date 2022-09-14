//
//  Preview.swift
//  Uniletter
//
//  Created by 권오준 on 2022/08/17.
//

import UIKit

enum ImageType {
    case basic
    case custom
}

struct Preview {
    var mainImage: UIImage
    var imageType: ImageType
    var imageUUID: String
    var title: String
    var host: String
    var category: String
    var target: String
    var startAt: String
    var endAt: String
    var contact: String
    var location: String
    var body: String
}
