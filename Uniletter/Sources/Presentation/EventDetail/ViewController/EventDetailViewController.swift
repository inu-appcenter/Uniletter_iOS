//
//  EventDetailViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit
import Kingfisher
import SnapKit

final class EventDetailViewController: UIViewController {
    
    // MARK: - Property
    let eventDetailView = EventDetailView()
    let viewModel = EventDetailViewModel()
    let loginManager = LoginManager.shared
    var id: Int = 0
    var bookmarkButton = UIButton()
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
    
    override func viewDidAppear(_ animated: Bool) {
        convertProfileImageToCircle()
    }
    
    // MARK: - Setup
    func setNavigationBar() {
        setNavigationTitleAndBackButton("읽어보기")
        
        let bookmarkButton: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 15, height: 23))
            button.setBackgroundImage(
                UIImage(named: "bookmark"),
                for: .normal)
            button.setBackgroundImage(
                UIImage(named: "bookmarkFill"),
                for: .selected)
            button.addTarget(
                self,
                action: #selector(didTapBookmarkButton(_:)),
                for: .touchUpInside)
            
            return button
        }()
        self.bookmarkButton = bookmarkButton
        
        let topMoreButton = UIBarButtonItem(
            image: UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(didTapTopMoreButton(_:)))
        
        self.navigationItem.rightBarButtonItems = [
            topMoreButton,
            UIBarButtonItem(customView: bookmarkButton)
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
        
        eventDetailView.bodyContentsTextView.text = viewModel.body
        eventDetailView.viewsLabel.text = viewModel.views
        eventDetailView.likeAndCommentsLabel.text = viewModel.likeAndComments
        
        updateProfileImage()
        updateMainImage()
        updateDDay()
        convertTextToHyperLink()
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
        let dateStr = viewModel.endAt
        let day = dateStr.caculateDateDiff()[0]
        let min = dateStr.caculateDateDiff()[1]
        let dday: String
        let buttonText: String
        
        if day < 0 || (day == 0 && min < 0) {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.darkGray)
            eventDetailView.notificationButton.backgroundColor = UIColor.customColor(.lightGray)
            
            dday = "마감"
            buttonText = "행사 마감"
        } else {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.blueGreen)
            eventDetailView.notificationButton.backgroundColor = UIColor.customColor(.blueGreen)
            
            dday = day == 0 ? "D-day" : "D-\(day)"
            buttonText = "알림 신청"
        }
        
        var ddayAttributed = AttributedString(dday)
        ddayAttributed.font = .systemFont(ofSize: 13)
        
        eventDetailView.ddayButton.configuration?.attributedTitle = ddayAttributed
        eventDetailView.notificationButton.setTitle(buttonText, for: .normal)
    }
    
    func convertProfileImageToCircle() {
        let imageView = eventDetailView.profileImageView
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
    }
    
    func convertTextToHyperLink() {
        let link = viewModel.link
        
        if link.contains("http") {
            let attributedString = NSMutableAttributedString(string: link)
            attributedString.addAttribute(
                .link,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: link.count))
            
            eventDetailView.infoStackView.linkLabel.attributedText = attributedString
        } else {
            eventDetailView.infoStackView.linkLabel.text = link
        }
    }
    
    func fetchEvents() {
        self.viewModel.loadEvent(self.id) {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
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
            let AlertView = self.AlertVC(.login)
            self.present(AlertView, animated: true)
            AlertView.cancleButtonClosure = {
                self.presentWaringView(.loginLike)
            }
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
            let presentActionVC = presentActionSheetView(.topForUser)
            self.present(presentActionVC, animated: true)

            presentActionVC.reportEventCompletionClosure = {
                let alertView = self.AlertVC(.login)
                self.present(alertView, animated: true)

                alertView.cancleButtonClosure = {
                    self.presentWaringView(.loginReport)
                }
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
                let alertView = self.AlertVC(.login)
                self.present(alertView, animated: true)
                
                alertView.cancleButtonClosure = {
                    self.presentWaringView(.loginBlock)
                }
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
            if viewModel.endAt.caculateDateDiff()[0] > 0 {
                
                let vc = presentActionSheetView(.notification)
                vc.eventID = id
                
                present(vc, animated: true)
                
                vc.notifyBeforeStartCompletionClosure = {
//                    self.presentNoticeAlertView(.startNotice)
                    self.presentNoticeAlertView(noticeAlert: .startNotice, check: false)
                }
                
                vc.notifyBeforeEndCompletionClosure = {
//                    self.presentNoticeAlertView(.deadlineNotice)
                    self.presentNoticeAlertView(noticeAlert: .deadlineNotice, check: false)
                }
            }
            
        } else {
            let AlertView = self.AlertVC(.login)
            self.present(AlertView, animated: true)
            AlertView.cancleButtonClosure = {
                self.presentWaringView(.loginNoti)
            }
        }
    }
    
    @objc func didTapLabel(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: viewModel.link) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}
