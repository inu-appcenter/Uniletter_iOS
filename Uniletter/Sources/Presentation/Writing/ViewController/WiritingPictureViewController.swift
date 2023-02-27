//
//  WiritingPictureViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import PhotosUI
import Kingfisher

final class WritingPictureViewController: BaseViewController {

    // MARK: - Property
    
    private let writingPictureView = WritingPictureView()
    private let writingManager = WritingManager.shared
    private lazy var constraint = writingPictureView.titleLabel.frame.height + 44
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = writingPictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.configureImageView()
        }
    }
    
    // MARK: - Configure
    
    override func configureViewController() {
        writingPictureView.recognizeTapImageView.addTarget(
            self,
            action: #selector(didTapimageView))
        writingPictureView.checkView.checkButton.addTarget(
            self,
            action: #selector(didTapCheckButton(_:)),
            for: .touchUpInside)
    }
    
    private func configureImageView() {
        if writingManager.isUpdating() {
            guard let url = URL(string: writingManager.imageURL!) else {
                return
            }
            
            writingPictureView.imageView.kf.setImage(with: url) { _ in
                self.updateImageViewRatio()
            }
            
            updateCheckButton()
        } else {
            updateImageViewRatio()
        }
    }
    
    func updateImageViewFromSave() {
        guard let url = URL(string: writingManager.imageURL!) else {
            return
        }
        
        writingPictureView.imageView.kf.setImage(with: url) { _ in
            self.updateImageViewRatio()
        }
        
        print(url)
        
        KingfisherManager.shared.retrieveImage(with: url) { result in
            let image = try? result.get().image
            
            if let image = image {
                self.writingManager.mainImage = image
            }
        }
            
        updateCheckButton()
    }
    
    // MARK: - Func
    
    private func updateImageViewRatio() {
        writingPictureView.imageView.updateImageViewRatio(.writing, constraint)
    }
    
    private func validateImageSize(_ image: UIImage) {
        let data = image.jpegData(compressionQuality: 1)!.count
        
        if data > 10000000 {
            presentNoticeAlertView(noticeAlert: .uploadImage, check: false)
        } else {
            writingManager.setImage(image)
            updateImage(image)
        }
    }
    
    private func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.writingPictureView.imageView.image = image
            self.updateImageViewRatio()
            self.updateCheckButton()
        }
    }
    
    private func updateDefaultImage() {
        writingPictureView.imageView.image = BasicInfo.etc.image
        updateImageViewRatio()
        writingManager.imageType = .basic
        writingManager.imageUUID = nil
    }
    
    private func updateCheckButton() {
        writingPictureView.checkView.checkButton.updateNotCheckedState()
    }

    // MARK: - Action
    
    @objc private func didTapimageView() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc private func didTapCheckButton(_ sender: CheckButton) {
        sender.updateState()
        
        if sender.isSelected {
            updateDefaultImage()
        }
    }
}

// MARK: - PHPickerViewController

extension WritingPictureViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage else {
                    print("이미지를 찾을 수 없습니다.")
                    return
                }
                
                DispatchQueue.main.async {
                    self.validateImageSize(image)
                }
                
            }
        }
    }
    
}
