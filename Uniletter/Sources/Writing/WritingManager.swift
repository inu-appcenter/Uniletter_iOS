//
//  WritingManager.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/18.
//

import UIKit

final class WritingManager {
    
    static let shared = WritingManager()
    
    // MARK: - Init
    private init() { }
    
    // MARK: - Property
    var basicImage = true
    var image: UIImage?
    
    // MARK: - Funcs
    func setImage(_ image: UIImage) {
        self.image = image
    }
    
    
}
