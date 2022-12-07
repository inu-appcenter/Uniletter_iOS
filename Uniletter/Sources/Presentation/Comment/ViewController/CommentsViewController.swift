//
//  CommentsViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/11.
//

import UIKit

final class CommentsViewController: BaseViewController {
    
    // MARK: - Property
    
    private let commentsView = CommentsView()
    private lazy var viewModel = CommentsViewModel(eventID)
    private var checkText = ""
    var eventID: Int!
    var userID: Int!
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = commentsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchComments()
    }
    
    // MARK: - Configure

    override func configureNavigationBar() {
        setNavigationTitleAndBackButton("댓글")
    }
    
    override func configureViewController() {
        configureTableView()
        configureTextField()
        
        commentsView.recognizeTapView.addTarget(self, action: #selector(hideKeyboard))
        commentsView.submitButton.addTarget(
            self,
            action: #selector(didTapSubmitButton),
            for: .touchUpInside)
    }
    
    private func configureTableView() {
        commentsView.tableView.dataSource = self
        commentsView.tableView.delegate = self
    }
    
    private func configureTextField() {
        commentsView.textField.delegate = self
        initUI()
    }
    
    // MARK: - Func
    
    private func fetchComments() {
        viewModel.loadComments { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
                self?.commentsView.tableView.reloadData()
            }
        }
    }
    
    private func writeComments() {
        guard let text = commentsView.textField.text else {
            return
        }
        
        viewModel.writeComments(text) { [weak self] in
            self?.initUI()
            self?.view.endEditing(true)
            self?.fetchComments()
        }
    }
    
    private func initUI() {
        commentsView.textField.text = "댓글을 입력해주세요."
        commentsView.textField.textColor = .customColor(.lightGray)
        
        commentsView.submitButton.isUserInteractionEnabled = false
        commentsView.submitButton.configuration?.baseBackgroundColor = .customColor(.lightGray)
    }
    
    private func updateUI() {
        commentsView.commentLabel.text = "댓글 \(viewModel.numofComments)"
    }
    
    private func updateSubmitButton(_ bool: Bool) {
        commentsView.submitButton.isUserInteractionEnabled = bool
        commentsView.submitButton.configuration?.baseBackgroundColor = bool
        ? .customColor(.blueGreen)
        : .customColor(.lightGray)
    }
    
    private func updateTextViewHeight(_ textView: UITextView) {
        if textView.frame.height >= 80 {
            textView.isScrollEnabled = true
            if textView.contentSize.height <= 80 {
                textView.isScrollEnabled = false
            }
        } else {
            textView.isScrollEnabled = false
        }
    }
    
    private func presentLoginwarnings() {
        let vc = presentActionSheetView(.commentForUser)
        vc.blockUserCompletionClousre = {
            self.presentLoginAlert(.loginBlock)
        }
        vc.reportCommentCompletionClisure = {
            self.presentLoginAlert(.loginReport)
        }
        
        self.present(vc, animated: true)
    }
    
    private func presentWroteByMeActionSheet(_ commentID: Int) {
        let vc = presentActionSheetView(.commentForWriter)
        vc.commentID = commentID
        
        vc.deleteCommentCompletionClosure = {
            self.fetchComments()
        }
        
        vc.blockUserCompletionClousre = {
            self.fetchComments()
        }
        
        self.present(vc, animated: true)
    }
    
    private func presentNotWroteByMeActionSheet(_ userID: Int) {
        let vc = presentActionSheetView(.commentForUser)
        vc.targetUserID = userID
        
        // FIXME: 댓글 신고 API 업데이트되면 변경 예정
        
        vc.reportCommentCompletionClisure = {
            self.presentWaringView(.reportComment)
        }
        
        vc.blockUserCompletionClousre = {
            self.presentWaringView(.blockUser)
            self.fetchComments()
        }
        
        self.present(vc, animated: true)
    }
    
    private func presentActionSheet(_ comment: Comment) {
        guard let wrote = comment.wroteByMe else {
            presentLoginwarnings()
            return
        }
        wrote
        ? presentWroteByMeActionSheet(comment.id)
        : presentNotWroteByMeActionSheet(comment.userID)
    }
    
    // MARK: - Action
    
    @objc private func hideKeyboard() {
        commentsView.endEditing(true)
    }
    
    @objc private func didTapSubmitButton() {
        if LoginManager.shared.isLoggedIn {
            writeComments()
        } else {
            presentLoginAlert(.loginComment)
        }
    }
    
}

// MARK: - TableView

extension CommentsViewController: UITableViewDataSource,
                                  UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int
    {
        return viewModel.numofComments
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentsCell.identifier,
            for: indexPath) as? CommentsCell else {
            return UITableViewCell()
        }
        
        let comment = viewModel.infoOfComment(indexPath.row)
        cell.updateUI(comment: comment, id: userID)
        
        cell.moreButtonTapHandler = {
            self.presentActionSheet(comment)
        }
        
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath)
    -> CGFloat
    {
        return UITableView.automaticDimension
    }
}

// MARK: - TextView

extension CommentsViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else {
            return
        }
        updateSubmitButton(!(text.trimmingCharacters(in: .whitespaces).isEmpty))
        updateTextViewHeight(textView)
        
        if textView.text.count > 300 {
            textView.deleteBackward()
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = textView.text == "댓글을 입력해주세요." ? "" : checkText
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            initUI()
        } else {
            checkText = textView.text
        }
    }
    
}
