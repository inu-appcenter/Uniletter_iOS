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
        viewModel.preview = self.preview
        setViewController()
    }
    
    // MARK: - Setup
    
    func setViewController() {
        previewView.titleLabel.text = viewModel.title
        
        previewView.infoStackView.categoryLabel.text = viewModel.category
        previewView.infoStackView.startLabel.text = viewModel.startAt
        previewView.infoStackView.endLabel.text = viewModel.endAt
        previewView.infoStackView.targetLabel.text = viewModel.target
        previewView.infoStackView.contactLabel.text = viewModel.contact
        previewView.bodyContentsTextView.text = viewModel.body
        
        updateImageView()
        updateDDay(viewModel.dday)
        convertTextToHyperLink()
        hideSubjects()
    }
    
    // MARK: - Funcs
    
    func hideSubjects() {
        if viewModel.category == " | " {
            previewView.infoStackView.validateInfo(.category, true)
        } else {
            previewView.infoStackView.validateInfo(.category, false)
        }
        
        if viewModel.target == "" {
            previewView.infoStackView.validateInfo(.target, true)
        } else {
            previewView.infoStackView.validateInfo(.target, false)
        }
        
        if viewModel.contact == "" {
            previewView.infoStackView.validateInfo(.contact, true)
        } else {
            previewView.infoStackView.validateInfo(.contact, false)
        }
        
        if viewModel.location == "" {
            previewView.infoStackView.validateInfo(.link, true)
        } else {
            previewView.infoStackView.validateInfo(.link, false)
        }
    }
    
    func convertTextToHyperLink() {
        let link = viewModel.location
        
        if link.contains("http") {
            let attributedString = NSMutableAttributedString(string: link)
            attributedString.addAttribute(
                .link,
                value: NSUnderlineStyle.single.rawValue,
                range: NSRange(location: 0, length: link.count))
            
            previewView.infoStackView.linkLabel.attributedText = attributedString
        } else {
            previewView.infoStackView.linkLabel.text = link
        }
    }
    
    func updateImageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.previewView.mainImageView.image = self.preview.mainImage
            self.previewView.mainImageView.updateImageViewRatio(false)
        }
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
