//
//  WritingDetailViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit

final class WritingDetailViewController: BaseViewController {

    // MARK: - Property
    
    private let writingDetailView = WritingDetailView()
    private let writingManager = WritingManager.shared
    private var checkText = ""
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = writingDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        writingDetailView.textField.delegate = self
        
        if writingManager.isUpdating() {
            writingDetailView.textField.text = writingManager.body
            checkText = writingManager.body
            
            if !(writingManager.body.isEmpty) {
                writingDetailView.textField.textColor = .black
            } else {
                writingDetailView.textField.text = writingManager.detailPlaceholder
            }
        }
    }
}

// MARK: - TextView

extension WritingDetailViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textView.isScrollEnabled = textView.frame.height >= 280 ? true : false
        
        if textView.text.count > 8000 {
            textView.deleteBackward()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = CGColor.customColor(.blueGreen)
        textView.text = textView.text == writingManager.detailPlaceholder ? "" : checkText
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespaces) == "" {
            textView.text = ""
        }
        
        textView.layer.borderColor = CGColor.customColor(.defaultGray)
        if textView.text == "" {
            textView.text = writingManager.detailPlaceholder
            textView.textColor = .customColor(.lightGray)
            writingManager.body = ""
        } else {
            checkText = textView.text
            writingManager.body = textView.text
        }
    }

}
