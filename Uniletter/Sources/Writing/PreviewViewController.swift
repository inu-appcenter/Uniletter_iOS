//
//  PreviewViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/08/14.
//

import UIKit
import Kingfisher

final class PreviewViewController: UIViewController {

    // MARK: - Property
    let eventDetailView = EventDetailView()
    var preview: Preview!
    var mainImage: UIImage!
    
    // MARK: - Life cycle
    override func loadView() {
        view = eventDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    // MARK: - Setup
    
    func setViewController() {
        [
            eventDetailView.profileImageView,
            eventDetailView.nicknameLabel,
            eventDetailView.dateWroteLabel,
            eventDetailView.moreButton,
            eventDetailView.notificationButton,
        ]
            .forEach { $0.isHidden = true }
        
        eventDetailView.mainImageView.image = mainImage
        eventDetailView.titleTextView.text = preview.title
        eventDetailView.categoryContentsLabel.text = preview.category
        eventDetailView.startContentsLabel.text = preview.startAt
        eventDetailView.endContentsLabel.text = preview.endAt
        eventDetailView.targetContentsLabel.text = preview.target
        eventDetailView.contactContentsLabel.text = preview.contact
        eventDetailView.bodyContentsLabel.text = preview.body
        
        updateDDay()
    }
    
    // MARK: - Funcs
    
    func updateDDay() {
        let dday = Int(caculateDDay(preview.endAt)) ?? 0
        let ddayText: String
        
        if dday < 0 {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.darkGray)
            eventDetailView.notificationButton.backgroundColor = UIColor.customColor(.lightGray)
            
            ddayText = "마감"
        } else {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.blueGreen)
            eventDetailView.notificationButton.backgroundColor = UIColor.customColor(.blueGreen)
            
            ddayText = dday == 0 ? "D-day" : "D-\(dday)"
        }
        
        var ddayAttributed = AttributedString(ddayText)
        ddayAttributed.font = .systemFont(ofSize: 13)
        
        eventDetailView.ddayButton.configuration?.attributedTitle = ddayAttributed
    }
    
}
