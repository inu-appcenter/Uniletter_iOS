//
//  ChangeViewModel.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/19.
//

import Foundation
import UIKit

class ChangeViewModel {
    
    var myPageManager = MyPageManager.shared
    
    var choiceImage: UIImage?
    var changeName: String?
    
    var userName: String {
        return myPageManager.userName!
    }
    
    var userImage: UIImage {
        return myPageManager.userImage!
    }
    
    func patchUserInfo(_ nickname: String, _ imageUuid: String) {
        let data: [String: String?] = [
                                    "nickname": nickname,
                                    "imageUuid": imageUuid
                                ]
        
        API.patchMeInfo(data: data)
    }
    
    func patchUserInfoNil(_ nickname: String) {
        let data: [String: String?] = [
                                    "nickname": nickname,
                                    "imageUuid": nil
                                    ]
        
        API.patchMeInfo(data: data)
    }
    
    func uploadUserInfo(_ nickname: String, _ image: UIImage?) {
        
        myPageManager.userName = self.changeName
        myPageManager.userImage = self.choiceImage
        
        if let userImage = image {
            API.uploadMeImage(image: userImage) { images in
                self.patchUserInfo(nickname, images.uuid)
            }
        } else {
            self.patchUserInfoNil(nickname)
        }
    }
}
