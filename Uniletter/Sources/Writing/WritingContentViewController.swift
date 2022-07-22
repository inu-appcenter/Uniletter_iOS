//
//  WritingContentViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import DropDown

class WritingContentViewController: UIViewController {

    // MARK: - Property
    let writingContentView = WritingContentView()
    let writingManager = WritingManager.shared
    let dropDown = DropDown()
    let categories = [
        "동아리/소모임",
        "학생회",
        "간식나눔",
        "대회/공모전",
        "스터디",
        "구인",
        "기타",
    ]
    let placeholer = "ex)총학생회, 디자인학부"
    
    // MARK: - Life cycle
    override func loadView() {
        view = writingContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
        setDropDown()
        initDropDown()
    }
    
    // MARK: - Setup
    func setViewController() {
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(downKeyboard(_:)))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        writingContentView.scrollView.addGestureRecognizer(recognizer)
        
        [
            writingContentView.titleView,
            writingContentView.hostView,
            writingContentView.targetView,
            writingContentView.contactView,
            writingContentView.locationView,
        ]
            .forEach { $0.textField.delegate = self }
        
        writingContentView.hostView.checkView.checkButton.addTarget(
            self,
            action: #selector(didTapHostCheckButton(_:)),
            for: .touchUpInside)
        writingContentView.categoryButton.addTarget(
            self,
            action: #selector(didTapCategoryButton(_:)),
            for: .touchUpInside)
        writingContentView.eventStartView.dateButton.addTarget(
            self,
            action: #selector(didTapStartDate(_:)),
            for: .touchUpInside)
        writingContentView.eventStartView.timeButton.addTarget(
            self,
            action: #selector(didTapStartTime(_:)),
            for: .touchUpInside)
        writingContentView.eventEndView.dateButton.addTarget(
            self,
            action: #selector(didTapEndDate(_:)),
            for: .touchUpInside)
        writingContentView.eventEndView.timeButton.addTarget(
            self,
            action: #selector(didTapEndTime(_:)),
            for: .touchUpInside)
        writingContentView.equalView.checkButton.addTarget(
            self,
            action: #selector(didTapEqaulCheckButton(_:)),
            for: .touchUpInside)
        writingContentView.contactView.checkView.checkButton.addTarget(
            self,
            action: #selector(didTapContactCheckButton(_:)),
            for: .touchUpInside)
        writingContentView.locationView.checkView.checkButton.addTarget(
            self,
            action: #selector(didTapLocationCheckButton(_:)),
            for: .touchUpInside)
    }

    func setDropDown() {
        dropDown.dataSource = categories
        dropDown.anchorView = writingContentView.categoryButton
        dropDown.dismissMode = .automatic
        dropDown.bottomOffset = CGPoint(x: 0, y: 44)
        dropDown.selectionAction = { index, item in
            self.writingManager.category = item
            self.writingManager.basicImage = self.writingManager.basicImageUUID[index]
            self.writingContentView.categoryView.textField.text = item
            self.writingContentView.categoryButton.isSelected = false
        }
        dropDown.cancelAction = {
            self.writingContentView.categoryButton.isSelected = false
        }
    }
    
    func initDropDown() {
        let dropDownAppearance = DropDown.appearance()
        dropDownAppearance.textColor = .black
        dropDownAppearance.selectedTextColor = .black
        dropDownAppearance.backgroundColor = .white
        dropDownAppearance.selectionBackgroundColor = UIColor.customColor(.blueGreen).withAlphaComponent(0.15)
        dropDownAppearance.setupCornerRadius(4)
    }
    
    // MARK: - Funcs
    func changeCheckButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        button.updateUI(button.isSelected)
    }
    
    // MARK: - Actions
    @objc func downKeyboard(_ sender: UITapGestureRecognizer) {
        writingContentView.endEditing(true)
    }
    
    @objc func didTapHostCheckButton(_ sender: UIButton) {
        changeCheckButton(sender)
        if sender.isSelected {
            writingContentView.hostView.textField.text = placeholer
            writingContentView.hostView.textField.textColor = UIColor.customColor(.lightGray)
            
            writingManager.host = ""
        }
    }
    
    @objc func didTapEqaulCheckButton(_ sender: UIButton) {
        changeCheckButton(sender)
        if sender.isSelected {
            writingContentView.eventEndView.dateButton.setAttributedTitle(
                showUnderline((writingContentView.eventStartView.dateButton.titleLabel?.text)!),
                for: .normal)
            writingContentView.eventEndView.timeButton.setAttributedTitle(
                showUnderline((writingContentView.eventStartView.timeButton.titleLabel?.text)!),
                for: .normal)
            
//            writingManager.endAt = writingManager.startAt
        }
    }
    
    @objc func didTapContactCheckButton(_ sender: UIButton) {
        changeCheckButton(sender)
        if sender.isSelected {
            writingContentView.contactView.textField.text = ""
        }
    }
    
    @objc func didTapLocationCheckButton(_ sender: UIButton) {
        changeCheckButton(sender)
        if sender.isSelected {
            writingContentView.locationView.textField.text = ""
        }
    }
    
    @objc func didTapCategoryButton(_ sender: UIButton) {
        dropDown.show()
        sender.isSelected = !sender.isSelected
    }
    
    @objc func didTapStartDate(_ sender: UIButton) {
        
    }
    
    @objc func didTapStartTime(_ sender: UIButton) {
        
    }
    
    @objc func didTapEndDate(_ sender: UIButton) {
        
    }
    
    @objc func didTapEndTime(_ sender: UIButton) {
        
    }
}

// MARK: - TextView
extension WritingContentViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 0 {
            switch textView {
            case writingContentView.hostView.textField:
                writingContentView.hostView.checkView.checkButton.updateUI(false)
                
            case writingContentView.contactView.textField:
                writingContentView.contactView.checkView.checkButton.updateUI(false)
                
            case writingContentView.locationView.textField:
                writingContentView.locationView.checkView.checkButton.updateUI(false)
                
            default:
                break
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = CGColor.customColor(.blueGreen)
        textView.textColor = .black
        
        if textView.text == placeholer {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespaces) == "" {
            textView.text = ""
        }
        
        textView.layer.borderColor = CGColor.customColor(.defaultGray)
        
        switch textView {
        case writingContentView.titleView.textField:
            if textView.text == "" {
                textView.layer.borderColor = #colorLiteral(red: 0.9664621949, green: 0.2374898791, blue: 0.1274906397, alpha: 1).cgColor
                writingManager.title = nil
            } else {
                writingManager.title = textView.text
            }
            
        case writingContentView.targetView.textField:
            if textView.text == "" {
                textView.layer.borderColor = #colorLiteral(red: 0.9664621949, green: 0.2374898791, blue: 0.1274906397, alpha: 1).cgColor
                writingManager.target = nil
            } else {
                writingManager.target = textView.text
            }
            
        case writingContentView.hostView.textField:
            if textView.text == "" {
                textView.text = placeholer
                textView.textColor = UIColor.customColor(.lightGray)
                writingContentView.hostView.checkView.checkButton.updateUI(true)
            }
            writingManager.host = textView.text
            
        case writingContentView.contactView.textField:
            if textView.text == "" {
                writingContentView.contactView.checkView.checkButton.updateUI(true)
            }
            writingManager.contact = textView.text
            
        case writingContentView.locationView.textField:
            if textView.text == "" {
                writingContentView.locationView.checkView.checkButton.updateUI(true)
            }
            writingManager.location = textView.text
            
        default:
            break
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
        
        return updatedText.count <= 40
    }

}
