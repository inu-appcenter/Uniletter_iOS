//
//  WritingTextFieldView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import SnapKit

final class WritingTextFieldView: UIView {

    // MARK: - UI
    let titleLabel = UILabel()
    
    lazy var textField: UITextView = {
        let textView = UITextView()
        textView.layer.cornerRadius = 4
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CGColor.customColor(.defaultGray)
        
        return textView
    }()
    
    // MARK: - Init
    
    
    // MARK: - Setup
}
