//
//  PreviewViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/08/14.
//

import UIKit
import SnapKit
import Kingfisher

final class PreviewViewController: UIViewController {

    // MARK: - Property
    let eventDetailView = EventDetailView()
    var preview: Preview!
    
    // MARK: - Life cycle
    override func loadView() {
        view = eventDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
            eventDetailView.viewsLabel,
            eventDetailView.likeAndCommentsLabel,
            eventDetailView.eyeImageView,
        ]
            .forEach { $0.isHidden = true }
        
        setImageSize()
        eventDetailView.mainImageView.image = preview.mainImage
        eventDetailView.titleTextView.text = preview.title
        eventDetailView.categoryContentsLabel.text = preview.category
        eventDetailView.startContentsLabel.text = self.convertTime(true)
        eventDetailView.endContentsLabel.text = self.convertTime(false)
        eventDetailView.targetContentsLabel.text = preview.target
        eventDetailView.contactContentsLabel.text = preview.contact
        eventDetailView.bodyContentsLabel.text = preview.body
        
        updateDDay(preview.endAt)
    }
    
    // MARK: - Funcs
    
    func setImageSize() {
        eventDetailView.mainImageView.contentMode = preview.imageType == .basic
        ? .scaleAspectFit
        : .scaleToFill
    }
    
    func convertTime(_ isStart: Bool) -> String {
        print(preview.startAt, preview.endAt)
        let hour = isStart
        ? Int(preview.startAt.subStringByIndex(sOffset: 11, eOffset: 13))!
        : Int(preview.endAt.subStringByIndex(sOffset: 11, eOffset: 13))!

        let min = isStart
        ? preview.startAt.subStringByIndex(sOffset: 14, eOffset: 16)
        : preview.endAt.subStringByIndex(sOffset: 14, eOffset: 16)
        
        if hour >= 12 {
            return (" - \(hour % 12):\(min) 오후")
        } else {
            return (" - \(hour):\(min) 오전")
        }
    }
    
    func updateDDay(_ dateStr: String) {
        let day = dateStr.caculateDateDiff()[0]
        let min = dateStr.caculateDateDiff()[1]
        let dday: String
        
        if day < 0 || (day == 0 && min < 0) {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.darkGray)
            dday = "마감"
        } else {
            eventDetailView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.blueGreen)
            dday = day == 0 ? "D-day" : "D-\(day)"
        }
        
        var attributedString = AttributedString(dday)
        attributedString.font = .systemFont(ofSize: 13)
        
        eventDetailView.ddayButton.configuration?.attributedTitle = attributedString
    }
    
}
