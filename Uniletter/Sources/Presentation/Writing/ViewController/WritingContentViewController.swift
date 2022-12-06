//
//  WritingContentViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import DropDown
import Kingfisher

final class WritingContentViewController: BaseViewController {

    // MARK: - Property
    
    private let writingContentView = WritingContentView()
    private let writingManager = WritingManager.shared
    private let dropDown = DropDown()
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = writingContentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        configureNotificationCenter()
        configureDateTime()
        configureDropDown()
        initUpdating()
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        writingContentView.recognizeTapView.addTarget(self, action: #selector(hideKeyboard))
        
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
            action: #selector(didTapStartDate),
            for: .touchUpInside)
        writingContentView.eventStartView.timeButton.addTarget(
            self,
            action: #selector(didTapStartTime),
            for: .touchUpInside)
        writingContentView.eventEndView.dateButton.addTarget(
            self,
            action: #selector(didTapEndDate),
            for: .touchUpInside)
        writingContentView.eventEndView.timeButton.addTarget(
            self,
            action: #selector(didTapEndTime),
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
    
    private func configureTextFields() {
        [
            writingContentView.titleView,
            writingContentView.hostView,
            writingContentView.targetView,
            writingContentView.contactView,
            writingContentView.locationView,
        ]
            .forEach { $0.textField.delegate = self }
    }
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkValidation),
            name: Notification.Name("validation"),
            object: nil)
    }
    
    private func configureDateTime() {
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

    private func configureDropDown() {
        dropDown.configureDropDownAppearance()
        dropDown.textColor = .black
        dropDown.setupCornerRadius(4)
        dropDown.dataSource = writingManager.categories
        dropDown.anchorView = writingContentView.categoryButton
        dropDown.bottomOffset = CGPoint(x: 0, y: 44)
        dropDown.selectRow(writingManager.categories.count - 1)
        
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
    
    private func initUpdating() {
        if writingManager.isUpdating() {
            writingContentView.titleView.textField.text = writingManager.title
            writingContentView.hostView.textField.text = writingManager.host
            writingContentView.categoryView.textField.text = writingManager.category
            writingContentView.targetView.textField.text = writingManager.target
            writingContentView.contactView.textField.text = writingManager.contact
            writingContentView.locationView.textField.text = writingManager.location
            
            if !(writingManager.host.isEmpty) {
                updateView(writingContentView.hostView)
            } else {
                writingContentView.hostView.textField.text = writingManager.hostPlaceholder
            }
            
            if !(writingManager.contact.isEmpty) {
                updateView(writingContentView.contactView)
            }
            if !(writingManager.location.isEmpty) {
                updateView(writingContentView.locationView)
            }
        }
    }
    
    // MARK: - Func
    
    private func updateView(_ view: WritingTextFieldView) {
        view.textField.textColor = .black
        view.checkView.checkButton.updateState()
    }
    
    private func presentCalendar(_ style: Style) {
        let vc = CalendarViewController()
        vc.style = style
        vc.delegate = self
        vc.setModalStyle()
        
        present(vc, animated: true)
    }
    
    private func presentTimePicker(_ style: Style) {
        let vc = TimePickerViewController()
        var time: String?
        
        time = style == .start ? writingManager.startTime : writingManager.endTime
        let subTime = CustomFormatter.subTimeForTimePicker(time!)
        
        vc.isPM = Int(time!.subStringByIndex(sOffset: 0, eOffset: 2))! < 12 ? false : true
        
        vc.style = style
        vc.hour = subTime[0]
        vc.minute = subTime[1]
        vc.delegate = self
        vc.setModalStyle()
        
        present(vc, animated: true)
    }
    
    private func updateHostView() {
        writingContentView.hostView.textField.text = writingManager.hostPlaceholder
        writingContentView.hostView.textField.textColor = .customColor(.lightGray)
        
        writingManager.host = ""
    }
    
    private func updateDateTime() {
        writingContentView.eventEndView.dateButton.setAttributedTitle(
            showUnderline((writingContentView.eventStartView.dateButton.titleLabel?.text)!),
            for: .normal)
        writingContentView.eventEndView.timeButton.setAttributedTitle(
            showUnderline((writingContentView.eventStartView.timeButton.titleLabel?.text)!),
            for: .normal)
        
        writingManager.equalDateTime()
    }
    
    private func updateContactView() {
        writingContentView.contactView.textField.text = ""
        writingManager.contact = ""
    }
    
    private func updateLocationView() {
        writingContentView.locationView.textField.text = ""
        writingManager.location = ""
    }
    
    // MARK: - Action
    
    @objc private func hideKeyboard() {
        writingContentView.endEditing(true)
    }
    
    @objc private func didTapHostCheckButton(_ sender: CheckButton) {
        sender.updateState()
        if sender.isSelected {
            updateHostView()
        }
    }
    
    @objc private func didTapEqaulCheckButton(_ sender: CheckButton) {
        sender.updateState()
        if sender.isSelected {
            updateDateTime()
        }
    }
    
    @objc private func didTapContactCheckButton(_ sender: CheckButton) {
        sender.updateState()
        if sender.isSelected {
            updateContactView()
        }
    }
    
    @objc private func didTapLocationCheckButton(_ sender: CheckButton) {
        sender.updateState()
        if sender.isSelected {
            updateLocationView()
        }
    }
    
    @objc private func didTapCategoryButton(_ sender: UIButton) {
        dropDown.show()
        sender.isSelected = !sender.isSelected
    }
    
    @objc private func didTapStartDate() {
        presentCalendar(.start)
    }
    
    @objc private func didTapStartTime() {
        presentTimePicker(.start)
    }
    
    @objc private func didTapEndDate() {
        presentCalendar(.end)
    }
    
    @objc private func didTapEndTime() {
        presentTimePicker(.end)
    }
    
    @objc private func checkValidation() {
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

// MARK: - DateSet, TimeSet Delegate

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
            writingContentView.hostView.checkView.checkButton.updateNotCheckedState()
        case writingContentView.contactView.textField:
            writingManager.contact = textView.text
            writingContentView.contactView.checkView.checkButton.updateNotCheckedState()
        case writingContentView.locationView.textField:
            writingManager.location = textView.text
            writingContentView.locationView.checkView.checkButton.updateNotCheckedState()
        default:
            break
        }
        
        if textView.text.count > 40 {
            textView.deleteBackward()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.layer.borderColor = .customColor(.blueGreen)
        textView.textColor = .black
        
        if textView.text == writingManager.hostPlaceholder {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespaces) == "" {
            textView.text = ""
        }
        
        textView.layer.borderColor = .customColor(.defaultGray)
        
        switch textView {
        case writingContentView.hostView.textField:
            if textView.text.isEmpty {
                textView.text = writingManager.hostPlaceholder
                textView.textColor = .customColor(.lightGray)
                writingContentView.hostView.checkView.checkButton.updateCheckedState()
            }
            writingManager.host = textView.text
        case writingContentView.contactView.textField:
            if textView.text.isEmpty {
                writingContentView.contactView.checkView.checkButton.updateCheckedState()
            }
            writingManager.contact = textView.text
        case writingContentView.locationView.textField:
            if textView.text.isEmpty {
                writingContentView.locationView.checkView.checkButton.updateCheckedState()
            }
            writingManager.location = textView.text
        default:
            break
        }
    }

}
