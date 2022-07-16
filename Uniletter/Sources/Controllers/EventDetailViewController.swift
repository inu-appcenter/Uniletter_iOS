//
//  EventDetailViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit
import Kingfisher

class EventDetailViewController: UIViewController {

    let eventDetailView = EventDetailView()
    let viewModel = EventDetailViewModel()
    var id: Int = 0
    var bookmarkButton: UIBarButtonItem?
    
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
    
    func setNavigationBar() {
        setNavigationTitleAndBackButton("읽어보기")
        
        let config = UIImage.SymbolConfiguration(pointSize: 18)
        let bookmarkButton = UIBarButtonItem(
            image: UIImage(systemName: "bookmark")?.withConfiguration(config),
            style: .done,
            target: self,
            action: #selector(bookmarkButtonDidTap(_:)))
        bookmarkButton.tintColor = UIColor.customColor(.lightGray)
        self.bookmarkButton = bookmarkButton
        
        let topMoreButton = UIBarButtonItem(
            image: UIImage(named: "ellipsis")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(didTapTopMoreButton(_:)))
        
        self.navigationItem.rightBarButtonItems = [
            topMoreButton,
            bookmarkButton,
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
    
    func updateUI() {
        bookmarkButton?.isSelected = viewModel.like
        changeBookmarkButton(viewModel.like)
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
    
    func changeBookmarkButton(_ isSelected: Bool) {
        bookmarkButton?.tintColor = .clear
        
        bookmarkButton?.image = isSelected
        ? UIImage(
                systemName: "bookmark.fill")?
                .withTintColor(
                    UIColor.customColor(.yellow),
                    renderingMode: .alwaysOriginal)
        : UIImage(
                systemName: "bookmark")?
                .withTintColor(
                    UIColor.customColor(.lightGray),
                    renderingMode: .alwaysOriginal)
    }

    @objc func bookmarkButtonDidTap(_ sender: UIBarButtonItem) {
        if LoginManager.shared.isLoggedIn {
            sender.isSelected = !sender.isSelected
            changeBookmarkButton(sender.isSelected)
            
            sender.isSelected ? viewModel.likeEvent() : viewModel.deleteLike()
            
            NotificationCenter.default.post(
                name: NSNotification.Name("like"),
                object: nil,
                userInfo: ["id": id, "like": sender.isSelected])
        } else {
            presentAlertView(.login)
        }
    }
    
    @objc func didTapTopMoreButton(_ sender: UIButton) {
        presentActionSheetView(.topForUser)
    }
    
    @objc func didTapProfileMoreButton(_ sender: UIButton) {
        presentActionSheetView(.profile)
    }
    
    @objc func didTapCommentesLabel(_ sender: UIButton) {
        let vc = CommentsViewController()
        vc.eventID = id
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func didTapNotificationButton(_ sender: UIButton) {
        if viewModel.dday > 0 {
            presentActionSheetView(.notification)
        }
    }
    
    @objc func didTapLabel(_ sender: UITapGestureRecognizer) {
        guard let url = URL(string: viewModel.link) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}
