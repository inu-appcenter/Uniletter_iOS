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
    var id: Int = 0
    let viewModel = EventDetailViewModel()
    
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
        
        let bookmarkButton = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 20))
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonDidTap(_:)), for: .touchUpInside)
        
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 20))
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .black
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: moreButton),
            UIBarButtonItem(customView: bookmarkButton),
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
            print("찾을 수 없음.")
            return
        }
        button.isSelected = !button.isSelected
        button.tintColor = button.isSelected
        ? UIColor.customColor(.yellow)
        : UIColor.customColor(.lightGray)
    }
}
