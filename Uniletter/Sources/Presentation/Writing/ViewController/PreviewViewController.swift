//
//  PreviewViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/08/14.
//

import UIKit
import SnapKit

final class PreviewViewController: UIViewController {

    // MARK: - Property
    let previewView = PreviewView()
    let viewModel = PreviewViewModel()
    var preview: Preview!
    
    // MARK: - Life cycle
    override func loadView() {
        view = previewView
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
        setImageSize()
        previewView.titleLabel.text = viewModel.title
        previewView.categoryContentsLabel.text = viewModel.category
        previewView.startContentsLabel.text = viewModel.startAt
        previewView.endContentsLabel.text = viewModel.endAt
        previewView.targetContentsLabel.text = viewModel.target
        previewView.contactContentsLabel.text = viewModel.contact
        previewView.linkContentsLabel.text = viewModel.location
        previewView.bodyContentsLabel.text = viewModel.body
        
        updateImageView()
        updateDDay(viewModel.dday)
    }
    
    // MARK: - Funcs
    
    func updateImageView() {
        previewView.mainImageView.image = preview.mainImage
        previewView.mainImageView.updateImageViewRatio(false)
    }
    
    func setImageSize() {
        previewView.mainImageView.contentMode = preview.imageType == .basic
        ? .scaleAspectFit
        : .scaleToFill
    }
    
    func updateDDay(_ dateStr: String) {
        let day = dateStr.caculateDateDiff()[0]
        let min = dateStr.caculateDateDiff()[1]
        let dday: String
        
        if day < 0 || (day == 0 && min < 0) {
            previewView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.darkGray)
            dday = "마감"
        } else {
            previewView.ddayButton.configuration?.baseBackgroundColor = UIColor.customColor(.blueGreen)
            dday = day == 0 ? "D-day" : "D-\(day)"
        }
        
        var attributedString = AttributedString(dday)
        attributedString.font = .systemFont(ofSize: 13)
        
        previewView.ddayButton.configuration?.attributedTitle = attributedString
    }
    
}
