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

final class EventDetailViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var bookmarkButton = UIBarButtonItem().then {
        let button = BookmarkButton(frame: CGRect(x: 0, y: 0, width: 15, height: 23)).then {
            $0.addTarget(
                self,
                action: #selector(didTapBookmarkButton(_:)),
                for: .touchUpInside)
        }
        
        $0.customView = button
    }
    
    private lazy var topMoreButton = UIBarButtonItem(
        image: UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal),
        style: .done,
        target: self,
        action: #selector(didTapTopMoreButton(_:)))
    
    // MARK: - Property
    
    private let eventDetailView = EventDetailView()
    private let viewModel = EventDetailViewModel()
    private let loginManager = LoginManager.shared
    var id: Int = 0
    var userBlockCompletionClosure: (() -> Void)?
    var userLikeCompletionClosure: (() -> Void)?
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = eventDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchEvents()
    }
    
    // MARK: - Setup
    
    func setNavigationBar() {
        setNavigationTitleAndBackButton("읽어보기")
        
        self.navigationItem.rightBarButtonItems = [
            topMoreButton,
            bookmarkButton
        ]
    }
    
    func setViewController() {
        eventDetailView.moreButton.addTarget(
            self,
            action: #selector(didTapProfileMoreButton(_:)),
            for: .touchUpInside)
        eventDetailView.notificationButton.addTarget(
            self,
            action: #selector(didTapNotificationButton(_:)),
            for: .touchUpInside)
        eventDetailView.recognizeTapLink.addTarget(
            self,
            action: #selector(didTapLabel(_:)))
        eventDetailView.commentsButton.addTarget(
            self,
            action: #selector(didTapCommentesLabel(_:)),
            for: .touchUpInside)
    }
    
    // MARK: - Funcs
    func updateUI() {
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
        
        updateProfileImage()
        updateMainImage()
        updateDDay()
        hideSubjects()
    }
    
    func hideSubjects() {
        if viewModel.categoryContent == " | " {
            eventDetailView.infoStackView.validateInfo(.category, true)
        }
        if viewModel.target == "" {
            eventDetailView.infoStackView.validateInfo(.target, true)
        }
        if viewModel.contact == "" {
            eventDetailView.infoStackView.validateInfo(.contact, true)
        }
        if viewModel.link == "" {
            eventDetailView.infoStackView.validateInfo(.link, true)
        }
    }
    
    func updateProfileImage() {
        if viewModel.profileImage == "" {
            eventDetailView.profileImageView.image = UIImage(named: "BasicProfileImage")
        } else {
            eventDetailView.profileImageView.kf.setImage(with: URL(string: viewModel.profileImage))
        }
    }
    
    func updateMainImage() {
        eventDetailView.mainImageView.kf.setImage(with: URL(string: viewModel.mainImage)!) { _ in
            self.eventDetailView.mainImageView.updateImageViewRatio(true)
        }
    }
    
    func updateDDay() {
        eventDetailView.ddayButton.updateDDay(viewModel.endAt)
        
        if eventDetailView.ddayButton.titleLabel?.text == "마감" {
            viewModel.notiState = .done
        } else {
            if let notiByMe = viewModel.event?.notificationSetByMe {
                viewModel.notiState = notiByMe ? .cancel : .request
            } else {
                viewModel.notiState = .request
            }
        }
        
        eventDetailView.notificationButton.updateButton(viewModel.notiState)
    }
    
    func fetchEvents() {
        self.viewModel.loadEvent(self.id) {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    private func deleteNotification() {
        viewModel.deleteNotification { [weak self] in
            self?.updateNotificationButton(.deleteNotice, .request)
        }
    }
    
    private func presentRequestAlert() {
        let vc = presentActionSheetView(.notification)
        vc.eventID = id
        
        vc.notifyBeforeStartCompletionClosure = {
            self.updateNotificationButton(.startNotice, .cancel)
        }
        
        vc.notifyBeforeEndCompletionClosure = {
            self.updateNotificationButton(.deadlineNotice, .cancel)
        }
        
        present(vc, animated: true)
    }
    
    private func updateNotificationButton(_ alert: NoticeAlert?, _ noti: NotiState) {
        if let alert = alert {
            presentNoticeAlertView(noticeAlert: alert, check: false)
        }
        viewModel.notiState = noti
        eventDetailView.notificationButton.updateButton(noti)
    }
    
    func postBlockNotification() {
        NotificationCenter.default.post(
            name: Notification.Name("HomeReload"),
            object: nil)
    }
    
    // MARK: - Actions
    @objc func didTapBookmarkButton(_ sender: UIButton) {
        if loginManager.isLoggedIn {
            sender.isSelected = !sender.isSelected
            
            sender.isSelected
            ? viewModel.likeEvent() { text in
                self.eventDetailView.likeAndCommentsLabel.text = text
            }
            : viewModel.deleteLike() { text in
                self.eventDetailView.likeAndCommentsLabel.text = text
            }
            
            NotificationCenter.default.post(
                name: NSNotification.Name("like"),
                object: nil,
                userInfo: ["id": id, "like": sender.isSelected])
            
            if let userLikeCompletionClosure = userLikeCompletionClosure {
                userLikeCompletionClosure()
            }
            
        } else {
            presentLoginAlert(.loginLike)
        }
    }
    
    @objc func didTapTopMoreButton(_ sender: UIButton) {
        let presentActionVC = presentActionSheetView(.topForUser)
        presentActionVC.eventID = id
        
        if loginManager.isLoggedIn {
            if viewModel.wroteByMe {
                print("내가쓴글")
                let id = viewModel.event?.id
                let vc = presentActionSheetView(.topForWriter)
                
                vc.eventID = id
                vc.event = viewModel.event
                
                self.present(vc, animated: true)
            } else {
                self.present(presentActionVC, animated: false)
                
                presentActionVC.reportEventCompletionClosure = {
                    self.presentWaringView(.reportEvent)
                }
            }
        } else {
            self.present(presentActionVC, animated: true)

            presentActionVC.reportEventCompletionClosure = {
                self.presentLoginAlert(.loginReport)
            }
        }
    }
    
    @objc func didTapProfileMoreButton(_ sender: UIButton) {
        if loginManager.isLoggedIn {
            let presentActionVC = presentActionSheetView(.profile)
            self.present(presentActionVC, animated: true)
            
            presentActionVC.blockUserCompletionClousre = {
                self.viewModel.postBlock(userId: self.viewModel.event!.userID) {
                    self.postBlockNotification()
                    self.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            let presentActionVC = presentActionSheetView(.profile)
            self.present(presentActionVC, animated: true)
            
            presentActionVC.blockUserCompletionClousre = {
                self.presentLoginAlert(.loginBlock)
            }
        }
    }
    
    @objc func didTapCommentesLabel(_ sender: UIButton) {
        let vc = CommentsViewController()
        vc.eventID = id
        vc.userID = viewModel.event?.userID
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapNotificationButton(_ sender: UIButton) {
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
    
    @objc func didTapLabel(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: viewModel.link) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}
