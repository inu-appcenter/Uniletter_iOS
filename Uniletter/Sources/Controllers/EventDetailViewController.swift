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
    
    override func loadView() {
        view = eventDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavigationBar()
        fetchEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        convertProfileImageToCircle()
    }
    
    func fetchEvents() {
        DispatchQueue.global().async {
            API.getEventOne(self.id) { event in
                self.viewModel.event = event
                DispatchQueue.main.async {
                    self.setViewController()
                }
            }
        }
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "읽어보기"
        
        let bookmarkButton = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .done,
            target: self,
            action: #selector(bookmarkButtonDidTap(_:)))
        bookmarkButton.tintColor = UIColor.customColor(.lightGray)
        
        let moreButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"),
            style: .done,
            target: self,
            action: #selector(moreButtonDidTap(_:)))
        moreButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItems = [
            moreButton,
            bookmarkButton,
        ]
    }
    
    func setViewController() {
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
        eventDetailView.linkContentsLabel.text = viewModel.link
        eventDetailView.bodyContentsLabel.text = viewModel.body
        eventDetailView.viewsLabel.text = viewModel.views
        eventDetailView.likeAndCommentsLabel.text = viewModel.likeAndComments
        updateDDay()
    }
    
    func updateDDay() {
        let dday = viewModel.dday
        let ddayText: String
        let buttonText: String
        
        if dday < 0 {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.darkGray)
            eventDetailView.notificationButton.backgroundColor = UIColor.customColor(.darkGray)
            
            ddayText = "마감"
            buttonText = "마감"
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

    @objc func bookmarkButtonDidTap(_ sender: UIButton) {
        guard let button = self.navigationItem.rightBarButtonItems?[1] else {
            return
        }
        
        button.isSelected = !button.isSelected
        button.tintColor = .clear
        
        if button.isSelected {
            button.image = UIImage(
                systemName: "bookmark.fill")?
                .withTintColor(UIColor.customColor(.yellow), renderingMode: .alwaysOriginal)
        } else {
            button.image = UIImage(
                systemName: "bookmark")?
                .withTintColor(UIColor.customColor(.lightGray), renderingMode: .alwaysOriginal)
        }
    }
    
    @objc func moreButtonDidTap(_ sender: UIButton) {
        print("more")
    }
}
