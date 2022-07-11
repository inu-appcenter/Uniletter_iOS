//
//  CommentsViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit

class CommentsViewController: UIViewController {

    // MARK: - Property
    let commentsView = CommentsView()
    var checkText: String = ""
    
    // MARK: - Life cycle
    override func loadView() {
        view = commentsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViewController()
    }
    
    // MARK: - Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Setup
    func setNavigationBar() {
        setNavigationTitleAndBackButton("댓글")
    }
    
    func setViewController() {
        commentsView.tableView.dataSource = self
        commentsView.tableView.delegate = self
        commentsView.textField.delegate = self
        
        commentsView.arrowButton.addTarget(
            self,
            action: #selector(didTapArrowButton(_:)),
            for: .touchUpInside)
        commentsView.submitButton.addTarget(
            self,
            action: #selector(didTapSubmitButton(_:)),
            for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc func didTapArrowButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    @objc func didTapSubmitButton(_ sender: UIButton) {
        
    }
}

// MARK: - TableView
extension CommentsViewController: UITableViewDataSource,
                                  UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentsCell.identifier,
            for: indexPath) as? CommentsCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
}

// MARK: - TextView
extension CommentsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != "" {
            commentsView.submitButton.isUserInteractionEnabled = true
            commentsView.submitButton.configuration?.baseBackgroundColor = UIColor.customColor(.blueGreen)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = textView.text == "댓글을 입력해주세요." ? "" : checkText
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "댓글을 입력해주세요."
            textView.textColor = UIColor.customColor(.lightGray)
            commentsView.submitButton.isUserInteractionEnabled = false
            commentsView.submitButton.configuration?.baseBackgroundColor = UIColor.customColor(.lightGray)
        } else {
            checkText = textView.text
        }
    }
}
