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
        previewView.infoStackView.linkLabel.attributedText = viewModel.location.convertToHyperLink()
        previewView.bodyContentsTextView.text = viewModel.body
        previewView.ddayButton.updateDDay(viewModel.dday)
        
        updateImageView()
        hideSubjects()
    }
    
    // MARK: - Funcs
    
    func hideSubjects() {
        previewView.infoStackView.validateInfo()
    }
    
    func updateImageView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.previewView.mainImageView.image = self.preview.mainImage
            self.previewView.mainImageView.updateImageViewRatio(false)
        }
    }
    
}
