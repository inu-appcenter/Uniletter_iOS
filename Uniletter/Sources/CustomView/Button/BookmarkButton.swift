//
//  BookmarkButton.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/05.
//

import UIKit

final class BookmarkButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func configureButton() {
        setBackgroundImage(UIImage(named: "bookmark"), for: .normal)
        setBackgroundImage(UIImage(named: "bookmarkFill"), for: .selected)
    }
    
}
