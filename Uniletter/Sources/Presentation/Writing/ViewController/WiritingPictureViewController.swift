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
    
    // MARK: - Life cycle
    
    override func loadView() {
        view = writingPictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if writingManager.isUpdating() {
            writingPictureView.imageView.kf.setImage(
                with: URL(string: writingManager.imageURL!)!)
            
            updateCheckButton()
        }
    }
    
    // MARK: - Func
    
    private func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.writingPictureView.imageView.image = image
            self.writingPictureView.imageView.contentMode = .scaleAspectFill
            self.updateCheckButton()
        }
    }
    
    private func updateDefaultImage() {
        writingPictureView.imageView.image = UIImage(named: "defaultImage")
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
                
                self.writingManager.setImage(image)
                self.updateImage(image)
            }
        }
    }
    
}
