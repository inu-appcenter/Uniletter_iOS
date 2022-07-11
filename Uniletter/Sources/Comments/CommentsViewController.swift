//
//  CommentsViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit
import SnapKit

class CommentsViewController: UIViewController {

    // MARK: - Property
    let commentsView = CommentsView()
    let viewModel = CommentsViewModel()
    var eventID: Int?
    var checkText = ""
    
    // MARK: - Life cycle
    override func loadView() {
        view = commentsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViewController()
        fetchComments()
        keyboardNofitications()
    }
    
    // MARK: - Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func keyboardNofitications() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputViewHeigt), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputViewHeigt), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustInputViewHeigt(noti: Notification) {
        guard let keyboardFrame = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        // TODO: - 레이아웃 에러 잡기
        if noti.name == UIResponder.keyboardWillShowNotification {
            commentsView.writeView.snp.remakeConstraints {
                $0.bottom.equalToSuperview().offset(-keyboardFrame.height)
            }
        } else {
            commentsView.writeView.snp.remakeConstraints {
                $0.bottom.equalTo(commentsView.safeAreaLayoutGuide)
            }
        }
    }
    
    
    // MARK: - Setup
    func setNavigationBar() {
        setNavigationTitleAndBackButton("댓글")
    }
    
    func setViewController() {
        viewModel.eventID = eventID
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
    
    func fetchComments() {
        guard let id = eventID else { return }
        
        DispatchQueue.global().async {
            self.viewModel.loadComments(id) {
                DispatchQueue.main.async {
                    self.commentsView.commentLabel.text = "댓글 \(self.viewModel.numofComments)"
                    self.commentsView.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Actions
    @objc func didTapArrowButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        commentsView.tableView.isHidden = !sender.isSelected
    }
    
    @objc func didTapSubmitButton(_ sender: UIButton) {
        viewModel.writeComments(commentsView.textField.text) {
            // TODO: - 댓글 쓴 후, 업데이트 하기 (fetchComments로는 안됨)
            self.fetchComments()
        }
    }
}

// MARK: - TableView
extension CommentsViewController: UITableViewDataSource,
                                  UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numofComments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentsCell.identifier,
            for: indexPath) as? CommentsCell else {
            return UITableViewCell()
        }
        
        let comment = viewModel.infoOfComment(indexPath.row)
        cell.selectionStyle = .none
        cell.updateUI(comment)
        
        cell.moreButtonTapHandler = {
            print("gd")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
