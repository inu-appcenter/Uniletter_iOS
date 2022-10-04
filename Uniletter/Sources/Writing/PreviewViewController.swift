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
    let viewModel = PreviewViewModel()
    var preview: Preview!
    
    // MARK: - Life cycle
    override func loadView() {
        view = eventDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewModel.preview = self.preview
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
        eventDetailView.titleTextView.text = viewModel.title
        eventDetailView.categoryContentsLabel.text = viewModel.category
        eventDetailView.startContentsLabel.text = viewModel.startAt
        eventDetailView.endContentsLabel.text = viewModel.endAt
        eventDetailView.targetContentsLabel.text = viewModel.target
        eventDetailView.contactContentsLabel.text = viewModel.contact
        eventDetailView.linkContentsLabel.text = viewModel.location
        eventDetailView.bodyContentsLabel.text = viewModel.body
        
        updateDDay(viewModel.dday)
    }
    
    // MARK: - Funcs
    
    func setImageSize() {
        eventDetailView.mainImageView.contentMode = preview.imageType == .basic
        ? .scaleAspectFit
        : .scaleToFill
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
