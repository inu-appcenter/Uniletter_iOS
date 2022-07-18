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
        "간식나눔",
        "대회/공모전",
        "스터디",
        "구인",
        "기타",
    ]
    
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
    
    // MARK: - Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Setup
    func setViewController() {
        writingContentView.hostView.checkView.checkButton.addTarget(
            self,
            action: #selector(didTapHostCheckButton(_:)),
            for: .touchUpInside)
        writingContentView.categoryButton.addTarget(
            self,
            action: #selector(didTapCategoryButton(_:)),
            for: .touchUpInside)
        writingContentView.startDateTapRecognize.addTarget(
            self,
            action: #selector(didTapStartDate(_:)))
        writingContentView.startTimeTapRecognize.addTarget(
            self,
            action: #selector(didTapStartTime(_:)))
        writingContentView.endDateTapRecognize.addTarget(
            self,
            action: #selector(didTapEndDate(_:)))
        writingContentView.endTimeTapRecognize.addTarget(
            self,
            action: #selector(didTapEndTime(_:)))
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
        dropDown.anchorView = writingContentView.categoryView
        dropDown.dismissMode = .automatic
        dropDown.bottomOffset = CGPoint(x: 0, y: 44)
        dropDown.selectionAction = { _, item in
            self.writingManager.category = item
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
    
    // MARK: - Actions
    @objc func didTapHostCheckButton(_ sender: UIButton) {
        
    }

    @objc func didTapCategoryButton(_ sender: UIButton) {
        print("d")
    }
    
    @objc func didTapStartDate(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func didTapStartTime(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func didTapEndDate(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func didTapEndTime(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func didTapContactCheckButton(_ sender: UIButton) {
        
    }
    
    @objc func didTapLocationCheckButton(_ sender: UIButton) {
        
    }
}
