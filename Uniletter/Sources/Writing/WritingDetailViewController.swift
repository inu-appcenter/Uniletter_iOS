//
//  WritingDetailViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit

final class WritingDetailViewController: UIViewController {

    // MARK: - Property
    let writingDetailView = WritingDetailView()
    let writingManager = WritingManager.shared
    let initText = "하위 게시물이나 부적절한 언어 사용 시\n유니레터 이용이 어려울 수 있습니다."
    var checkText = ""
    
    // MARK: - Life cycle
    override func loadView() {
        view = writingDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    // MARK: - Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        writingDetailView.endEditing(true)
    }
    
    // MARK: - Setup
    func setViewController() {
        writingDetailView.textField.delegate = self
    }
}

// MARK: - TextView
extension WritingDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textView.isScrollEnabled = textView.frame.height >= 280 ? true : false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = CGColor.customColor(.blueGreen)
        textView.text = textView.text == initText ? "" : checkText
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespaces) == "" {
            textView.text = ""
        }
        
        textView.layer.borderColor = CGColor.customColor(.defaultGray)
        if textView.text == "" {
            textView.text = initText
            textView.textColor = UIColor.customColor(.lightGray)
            writingManager.body = ""
        } else {
            checkText = textView.text
            writingManager.body = textView.text
        }
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String)
    -> Bool {
        guard let term = textView.text,
              let stringRange = Range(range, in: term) else {
            return false
        }
        let updatedText = term.replacingCharacters(
            in: stringRange,
            with: text)
        
        return updatedText.count <= 800
    }
}
