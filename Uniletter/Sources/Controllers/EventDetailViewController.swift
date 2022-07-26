//
//  EventDetailViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit
import Kingfisher

final class EventDetailViewController: UIViewController {
    
    // MARK: - Property
    let eventDetailView = EventDetailView()
    let viewModel = EventDetailViewModel()
    let loginManager = LoginManager.shared
    var id: Int = 0
    var bookmarkButton = UIButton()
    
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
        eventDetailView.profileImageView.image = viewModel.profileImage
        eventDetailView.nicknameLabel.text = viewModel.nickname
        eventDetailView.dateWroteLabel.text = viewModel.dateWrote
        eventDetailView.mainImageView.image = viewModel.mainImage
        eventDetailView.titleTextView.text = viewModel.title
        eventDetailView.categoryContentsLabel.text = viewModel.categoryContent
        eventDetailView.startContentsLabel.text = viewModel.startContent
        eventDetailView.endContentsLabel.text = viewModel.endContent
        eventDetailView.targetContentsLabel.text = viewModel.target
        eventDetailView.contactContentsLabel.text = viewModel.contact
        eventDetailView.bodyContentsLabel.text = viewModel.body
        eventDetailView.viewsLabel.text = viewModel.views
        eventDetailView.likeAndCommentsLabel.text = viewModel.likeAndComments
        updateDDay()
        convertTextToHyperLink()
    }
    
    func updateDDay() {
        let dday = viewModel.dday
        let ddayText: String
        let buttonText: String
        
        if dday < 0 {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.darkGray)
            eventDetailView.notificationButton.backgroundColor = UIColor.customColor(.lightGray)
            
            ddayText = "마감"
            buttonText = "행사 마감"
        } else {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.blueGreen)
            eventDetailView.notificationButton.backgroundColor = UIColor.customColor(.blueGreen)
            
            ddayText = dday == 0 ? "D-day" : "D-\(dday)"
            buttonText = "알림 신청"
        }
        
        var ddayAttributed = AttributedString(ddayText)
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
        if viewModel.link.contains("http") {
            let attributedString = NSMutableAttributedString(string: viewModel.link)
            attributedString.addAttribute(
                .link,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: viewModel.link.count))
            
            eventDetailView.linkContentsLabel.attributedText = attributedString
        } else {
            eventDetailView.linkContentsLabel.text = viewModel.link
        }
    }
    
    func fetchEvents() {
        DispatchQueue.global().async {
            self.viewModel.loadEvent(self.id) {
                DispatchQueue.main.async {
                    self.updateUI()
                }
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
        self.present(presentActionVC, animated: true)
        
        presentActionVC.reportUserCompletionClosure = {
            let alertView = self.AlertVC(.login)
            self.present(alertView, animated: true)
            
            alertView.cancleButtonClosure = {
                self.presentWaringView(.loginReport)
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
            if viewModel.dday > 0 {
                self.present(presentActionSheetView(.notification), animated: true)
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
