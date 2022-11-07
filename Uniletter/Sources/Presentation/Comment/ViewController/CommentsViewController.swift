//
//  CommentsViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit
import SnapKit

final class CommentsViewController: UIViewController {
    
    // MARK: - Property
    let commentsView = CommentsView()
    let viewModel = CommentsViewModel()
    var eventID: Int?
    var userID: Int!
    var checkText = ""
    
    // MARK: - Life cycle
    override func loadView() {
        view = commentsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchComments()
    }
    
    // MARK: - Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        commentsView.endEditing(true)
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
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reload),
            name: NSNotification.Name("reload"),
            object: nil)
        
        // 입력 뷰 키보드 따라가기
        view.keyboardLayoutGuide.topAnchor.constraint(equalTo: commentsView.writeView.bottomAnchor).isActive = true
    }
    
    func initTextField() {
        commentsView.textField.text = "댓글을 입력해주세요."
        commentsView.textField.textColor = UIColor.customColor(.lightGray)
        commentsView.submitButton.isUserInteractionEnabled = false
        commentsView.submitButton.configuration?.baseBackgroundColor = UIColor.customColor(.lightGray)
    }
    
    func updateUI() {
        commentsView.commentLabel.text = "댓글 \(viewModel.numofComments)"
    }
    
    func fetchComments() {
        guard let id = eventID else { return }
        
        self.viewModel.loadComments(id) {
            DispatchQueue.main.async {
                self.updateUI()
                self.commentsView.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    @objc func didTapArrowButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        commentsView.tableView.isHidden = !sender.isSelected
    }
    
    @objc func didTapSubmitButton(_ sender: UIButton) {
        if LoginManager.shared.isLoggedIn {
            viewModel.writeComments(commentsView.textField.text) {
                self.initTextField()
                self.view.endEditing(true)
                self.fetchComments()
            }
        } else {
            let alertView = AlertVC(.login)
            present(alertView, animated: true)
            alertView.cancleButtonClosure = {
                self.presentWaringView(.loginComment)
            }
        }
    }
    
    @objc func reload() {
        fetchComments()
    }
}

// MARK: - TableView
extension CommentsViewController: UITableViewDataSource,
                                  UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int {
        return viewModel.numofComments
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentsCell.identifier,
            for: indexPath) as? CommentsCell else {
            return UITableViewCell()
        }
        
        let comment = viewModel.infoOfComment(indexPath.row)
        cell.selectionStyle = .none
        cell.updateUI(comment: comment, id: userID)
        
        cell.moreButtonTapHandler = {
            var vc = ActionSheetViewController()

            guard let wrote = comment.wroteByMe else {
                vc = self.presentActionSheetView(.commentForUser)
                self.present(vc, animated: true)

                let AlertView = self.AlertVC(.login)

                vc.blockUserCompletionClousre = {
                    self.present(AlertView, animated: true)
                    AlertView.cancleButtonClosure = {
                        self.presentWaringView(.loginBlock)
                    }
                }

                vc.reportCommentCompletionClisure = {
                    self.present(AlertView, animated: true)
                    AlertView.cancleButtonClosure = {
                        self.presentWaringView(.loginReport)
                    }
                }
                
                return }
            
            if wrote {
                vc = self.presentActionSheetView(.commentForWriter)
                vc.commentID = comment.id
                
            } else {
                vc = self.presentActionSheetView(.commentForUser)
                vc.targetUserID = comment.userID
                
                // FIXME: 댓글 신고 API 업데이트되면 변경 예정
                
                vc.reportCommentCompletionClisure = {
                    self.presentWaringView(.reportComment)
                }
            }
            
            self.present(vc, animated: true)
        }
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
            self.view.endEditing(true)
        }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath)
    -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - TextView
extension CommentsViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != ""
            && textView.text.trimmingCharacters(in: .whitespaces) != "" {
            commentsView.submitButton.isUserInteractionEnabled = true
            commentsView.submitButton.configuration?.baseBackgroundColor = UIColor.customColor(.blueGreen)
        } else {
            commentsView.submitButton.isUserInteractionEnabled = false
            commentsView.submitButton.configuration?.baseBackgroundColor = UIColor.customColor(.lightGray)
        }
        
        textView.isScrollEnabled = textView.frame.height >= 80 ? true : false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = textView.text == "댓글을 입력해주세요." ? "" : checkText
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            initTextField()
        } else {
            checkText = textView.text
        }
    }
    
    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String)
    -> Bool {
        guard let term = commentsView.textField.text,
              let stringRange = Range(range, in: term) else {
            return false
        }
        let updatedText = term.replacingCharacters(
            in: stringRange,
            with: text)
        
        return updatedText.count <= 300
    }
}
