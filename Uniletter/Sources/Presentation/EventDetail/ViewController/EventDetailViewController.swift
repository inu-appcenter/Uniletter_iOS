//
//  EventDetailViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class EventDetailViewController: BaseViewController {
    
    // MARK: - UI
    
    private lazy var bookmarkButton = BookmarkButton(
        frame: CGRect(x: 0, y: 0, width: 15, height: 23)).then
    {
        $0.addTarget(
            self,
            action: #selector(didTapBookmarkButton(_:)),
            for: .touchUpInside)
    }
    
    private lazy var topMoreButton = UIBarButtonItem(
        image: UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal),
        style: .done,
        target: self,
        action: #selector(didTapTopMoreButton))
    
    // MARK: - Property
    
    private let eventDetailView = EventDetailView()
    private let loginManager = LoginManager.shared
    private lazy var viewModel = EventDetailViewModel(id: id)
    var id: Int = 0
    var userBlockCompletionClosure: (() -> Void)?
    var userLikeCompletionClosure: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = eventDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEvents()
    }
    
    // MARK: - Configure
    
    override func configureNavigationBar() {
        setNavigationTitleAndBackButton("읽어보기")
        
        self.navigationItem.rightBarButtonItems = [
            topMoreButton,
            UIBarButtonItem(customView: bookmarkButton)
        ]
    }
    
    override func configureViewController() {
        eventDetailView.moreButton.addTarget(
            self,
            action: #selector(didTapProfileMoreButton),
            for: .touchUpInside)
        eventDetailView.notificationButton.addTarget(
            self,
            action: #selector(didTapNotificationButton),
            for: .touchUpInside)
        eventDetailView.recognizeTapLink.addTarget(
            self,
            action: #selector(didTapLabel))
        eventDetailView.commentsButton.addTarget(
            self,
            action: #selector(didTapCommentesLabel),
            for: .touchUpInside)
    }
    
    // MARK: - Func
    
    private func fetchEvents() {
        viewModel.loadEvent { [weak self] in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    private func updateUI() {
        bookmarkButton.isSelected = viewModel.like
        eventDetailView.moreButton.isHidden = viewModel.wroteByMe
        eventDetailView.nicknameLabel.text = viewModel.nickname
        eventDetailView.dateWroteLabel.text = viewModel.dateWrote
        eventDetailView.titleLabel.text = viewModel.title
        
        eventDetailView.infoStackView.categoryLabel.text = viewModel.categoryContent
        eventDetailView.infoStackView.startLabel.text = viewModel.startContent
        eventDetailView.infoStackView.endLabel.text = viewModel.endContent
        eventDetailView.infoStackView.targetLabel.text = viewModel.target
        eventDetailView.infoStackView.contactLabel.text = viewModel.contact
        eventDetailView.infoStackView.linkLabel.attributedText = viewModel.link.convertToHyperLink()
        
        eventDetailView.bodyContentsTextView.text = viewModel.body
        eventDetailView.viewsLabel.text = viewModel.views
        eventDetailView.likeAndCommentsLabel.text = viewModel.likeAndComments
        
        eventDetailView.notificationButton.updateButton(viewModel.notiState)
        
        updateProfileImage()
        updateMainImage()
        updateDDay()
        hideSubjects()
    }
    
    private func hideSubjects() {
        eventDetailView.infoStackView.validateInfo()
    }
    
    private func updateProfileImage() {
        if viewModel.profileImage == "" {
            eventDetailView.profileImageView.image = UIImage(named: "BasicProfileImage")
        } else {
            eventDetailView.profileImageView.kf.setImage(with: URL(string: viewModel.profileImage))
        }
    }
    
    private func updateMainImage() {
        eventDetailView.mainImageView.kf.setImage(with: URL(string: viewModel.mainImage)!) { _ in
            self.eventDetailView.mainImageView.updateImageViewRatio(true)
        }
    }
    
    private func updateDDay() {
        eventDetailView.ddayButton.updateDDay(viewModel.endAt)
        
        if eventDetailView.ddayButton.titleLabel?.text == "마감" {
            eventDetailView.notificationButton.updateButton(.done)
        }
    }
    
    private func updateLike(_ like: Bool) {
        like
        ? viewModel.likeEvent() { [weak self] text in
            self?.eventDetailView.likeAndCommentsLabel.text = text
        }
        : viewModel.deleteLike() { [weak self] text in
            self?.eventDetailView.likeAndCommentsLabel.text = text
        }
        
        postLikeNotification(id, like)
        userLikeCompletionClosure?()
    }
    
    private func blockUser() {
        viewModel.postBlock(userId: viewModel.userID) { [weak self] in
            self?.postHomeReloadNotification()
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func deleteNotification() {
        viewModel.deleteNotification { [weak self] in
            self?.updateNotificationButton(.deleteNotice)
        }
    }
    
    private func presentTopMoreActionSheet() {
        if viewModel.wroteByMe {
            let vc = presentActionSheetView(.topForWriter)
            vc.eventID = id
            vc.event = viewModel.eventInfo
            
            self.present(vc, animated: true)
        } else {
            let vc = presentActionSheetView(.topForUser)
            vc.eventID = id
            vc.reportEventCompletionClosure = {
                self.presentWaringView(.reportEvent)
            }
            
            self.present(vc, animated: false)
        }
    }
    
    private func presentRequestAlert() {
        let vc = presentActionSheetView(.notification)
        vc.eventID = id
        
        vc.notifyBeforeStartCompletionClosure = {
            self.updateNotificationButton(.startNotice)
        }
        
        vc.notifyBeforeEndCompletionClosure = {
            self.updateNotificationButton(.deadlineNotice)
        }
        
        present(vc, animated: true)
    }
    
    private func updateNotificationButton(_ alert: NoticeAlert) {
        fetchEvents()
        presentNoticeAlertView(noticeAlert: alert, check: false)
    }
    
    // MARK: - Action
    
    @objc private func didTapBookmarkButton(_ sender: UIButton) {
        if loginManager.isLoggedIn {
            sender.isSelected = !sender.isSelected
            updateLike(sender.isSelected)
        } else {
            presentLoginAlert(.loginLike)
        }
    }
    
    @objc private func didTapTopMoreButton() {
        if loginManager.isLoggedIn {
            presentTopMoreActionSheet()
        } else {
            presentLoginAlert(.loginReport)
        }
    }
    
    @objc private func didTapProfileMoreButton() {
        let vc = presentActionSheetView(.profile)
        
        vc.blockUserCompletionClousre = {
            self.loginManager.isLoggedIn ? self.blockUser() : self.presentLoginAlert(.loginBlock)
        }
        self.present(vc, animated: true)
    }
    
    @objc private func didTapCommentesLabel() {
        let vc = CommentsViewController()
        vc.eventID = id
        vc.userID = viewModel.userID
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapNotificationButton() {
        if loginManager.isLoggedIn {
            switch viewModel.notiState {
            case .request:
                presentRequestAlert()
            case .cancel:
                deleteNotification()
            case .done:
                break
            }
        } else {
            presentLoginAlert(.loginNoti)
        }
    }
    
    @objc private func didTapLabel() {
        openURL(viewModel.link)
    }
    
}
