//
//  WritingContentViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import DropDown
import Kingfisher

class WritingContentViewController: UIViewController {

    // MARK: - Property
    let writingContentView = WritingContentView()
    let writingManager = WritingManager.shared
    let dropDown = DropDown()
    let categories = [
        "선택없음",
        "동아리/소모임",
        "학생회",
        "간식나눔",
        "대회/공모전",
        "스터디",
        "구인",
        "기타",
    ]
    let placeholer = "ex)총학생회, 디자인학부"
    var event: Event?
    
    // MARK: - Life cycle
    override func loadView() {
        view = writingContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
        initDateTime()
        setDropDown()
        initUpdating()
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkValidation(_:)),
            name: Notification.Name("validation"),
            object: nil)
    }
    
    func initDateTime() {
        writingContentView.eventStartView.dateButton.setAttributedTitle(
            showUnderline(writingManager.startDate),
            for: .normal)
        writingContentView.eventStartView.timeButton.setAttributedTitle(
            showUnderline(CustomFormatter.convertTime(writingManager.startTime)),
            for: .normal)
        writingContentView.eventEndView.dateButton.setAttributedTitle(
            showUnderline(writingManager.endDate),
            for: .normal)
        writingContentView.eventEndView.timeButton.setAttributedTitle(
            showUnderline(CustomFormatter.convertTime(writingManager.endTime)),
            for: .normal)
    }

    func setDropDown() {
        dropDown.configureDropDownAppearance()
        dropDown.textColor = .black
        dropDown.setupCornerRadius(4)
        dropDown.dataSource = categories
        dropDown.anchorView = writingContentView.categoryButton
        dropDown.dismissMode = .automatic
        dropDown.bottomOffset = CGPoint(x: 0, y: 44)
        dropDown.selectionAction = { index, item in
            self.writingManager.category = item
            self.writingManager.imageIndex = index
            self.writingContentView.categoryView.textField.text = item
            self.writingContentView.categoryButton.isSelected = false
        }
        dropDown.cancelAction = {
            self.writingContentView.categoryButton.isSelected = false
        }
    }
    
    func initUpdating() {
        if writingManager.isUpdating() {
            writingContentView.titleView.textField.text = writingManager.title
            writingContentView.hostView.textField.text = writingManager.host
            writingContentView.categoryView.textField.text = writingManager.category
            writingContentView.targetView.textField.text = writingManager.target
            writingContentView.contactView.textField.text = writingManager.contact
            writingContentView.locationView.textField.text = writingManager.location
            
            if !(writingManager.host.isEmpty) {
                writingContentView.hostView.textField.textColor = .black
                changeCheckButton(writingContentView.hostView.checkView.checkButton)
            } else {
                writingContentView.hostView.textField.text = placeholer
            }
            
            if !(writingManager.contact.isEmpty) {
                writingContentView.contactView.textField.textColor = .black
                changeCheckButton(writingContentView.contactView.checkView.checkButton)
            }
            if !(writingManager.location.isEmpty) {
                writingContentView.locationView.textField.textColor = .black
                changeCheckButton(writingContentView.locationView.checkView.checkButton)
            }
        }
    }
    
    // MARK: - Funcs
    func changeCheckButton(_ button: UIButton) {
        button.isSelected = !button.isSelected
        button.updateUI(button.isSelected)
    }
    
    func presentCalendar(_ style: Style) {
        let vc = CalendarViewController()
        vc.style = style
        vc.delegate = self
        vc.setModalStyle()
        
        present(vc, animated: true)
    }
    
    func presentTimePicker(_ style: Style) {
        let vc = TimePickerViewController()
        var time: String?
        
        time = style == .start ? writingManager.startTime : writingManager.endTime
        let subTime = CustomFormatter.subTimeForTimePicker(time!)
        
        vc.isPM = Int(time!.subStringByIndex(sOffset: 0, eOffset: 2))! < 12
        ? false : true
        
        vc.style = style
        vc.hour = subTime[0]
        vc.minute = subTime[1]
        vc.delegate = self
        vc.setModalStyle()
        
        present(vc, animated: true)
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
            
            writingManager.equalDateTime()
        }
    }
    
    @objc func didTapContactCheckButton(_ sender: UIButton) {
        changeCheckButton(sender)
        if sender.isSelected {
            writingContentView.contactView.textField.text = ""
            writingManager.contact = ""
        }
    }
    
    @objc func didTapLocationCheckButton(_ sender: UIButton) {
        changeCheckButton(sender)
        if sender.isSelected {
            writingContentView.locationView.textField.text = ""
            writingManager.location = ""
        }
    }
    
    @objc func didTapCategoryButton(_ sender: UIButton) {
        dropDown.show()
        sender.isSelected = !sender.isSelected
    }
    
    @objc func didTapStartDate(_ sender: UIButton) {
        presentCalendar(.start)
    }
    
    @objc func didTapStartTime(_ sender: UIButton) {
        presentTimePicker(.start)
    }
    
    @objc func didTapEndDate(_ sender: UIButton) {
        presentCalendar(.end)
    }
    
    @objc func didTapEndTime(_ sender: UIButton) {
        presentTimePicker(.end)
    }
    
    @objc func checkValidation(_ sender: Any) {
        let validation = writingManager.checkEventInfo()
        
        if validation != .success {
            presentWaringView(.writing)
        }
        
        switch validation {
        case .success: break
        case .title:
            writingContentView.titleView.textField.layer.borderColor = #colorLiteral(red: 0.9664621949, green: 0.2374898791, blue: 0.1274906397, alpha: 1).cgColor
        case .target:
            writingContentView.targetView.textField.layer.borderColor = #colorLiteral(red: 0.9664621949, green: 0.2374898791, blue: 0.1274906397, alpha: 1).cgColor
        case .both:
            writingContentView.titleView.textField.layer.borderColor = #colorLiteral(red: 0.9664621949, green: 0.2374898791, blue: 0.1274906397, alpha: 1).cgColor
            writingContentView.targetView.textField.layer.borderColor = #colorLiteral(red: 0.9664621949, green: 0.2374898791, blue: 0.1274906397, alpha: 1).cgColor
        }
    }
}

extension WritingContentViewController: DateSetDelegate,
                                        TimeSetDelegate {
    func setDate(date: String, style: Style) {
        style == .start
        ? writingContentView.eventStartView.dateButton
            .setAttributedTitle(showUnderline(date), for: .normal)
        : writingContentView.eventEndView.dateButton
            .setAttributedTitle(showUnderline(date), for: .normal)
    }
    
    func setTime(time: String, style: Style) {
        style == .start
        ? writingContentView.eventStartView.timeButton
            .setAttributedTitle(showUnderline(time), for: .normal)
        : writingContentView.eventEndView.timeButton
            .setAttributedTitle(showUnderline(time), for: .normal)
    }
}

// MARK: - TextView
extension WritingContentViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case writingContentView.titleView.textField:
            writingManager.title = textView.text
            
        case writingContentView.targetView.textField:
            writingManager.target = textView.text
            
        case writingContentView.hostView.textField:
            writingManager.host = textView.text
            writingContentView.hostView.checkView.checkButton.updateUI(false)
            
        case writingContentView.contactView.textField:
            writingManager.contact = textView.text
            writingContentView.contactView.checkView.checkButton.updateUI(false)
            
        case writingContentView.locationView.textField:
            writingManager.location = textView.text
            writingContentView.locationView.checkView.checkButton.updateUI(false)
            
        default:
            break
        }
        
        if textView.text.count > 40 {
            textView.deleteBackward()
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

}
