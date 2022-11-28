//
//  WiritingPictureViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import PhotosUI
import Kingfisher

final class WritingPictureViewController: UIViewController {

    // MARK: - Property
    let writingPictureView = WritingPictureView()
    let writingManager = WritingManager.shared
    
    // MARK: - Life cycle
    override func loadView() {
        view = writingPictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewContoller()
    }
    
    // MARK: - Setup
    func setViewContoller() {
        writingPictureView.recognizeTapImageView.addTarget(
            self,
            action: #selector(didTapimageView(_:)))
        writingPictureView.checkView.checkButton.addTarget(
            self,
            action: #selector(didTapCheckButton(_:)),
            for: .touchUpInside)
        
        if writingManager.isUpdating() {
            self.writingPictureView.imageView.kf.setImage(
                with: URL(string: writingManager.imageURL!)!)
            
            self.writingPictureView.checkView.checkButton.isSelected = false
            self.writingPictureView.checkView.checkButton.updateUI(false)
        }
    }
    
    // MARK: - Func
    
    func updateImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.writingPictureView.imageView.image = image
            self.writingPictureView.imageView.contentMode = .scaleAspectFill
            self.writingPictureView.checkView.checkButton.isSelected = false
            self.writingPictureView.checkView.checkButton.updateUI(false)
        }
    }

    // MARK: - Actions
    @objc func didTapimageView(_ sender: UITapGestureRecognizer) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        self.present(picker, animated: true)
    }
    
    @objc func didTapCheckButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.updateUI(sender.isSelected)
        
        if sender.isSelected {
            writingPictureView.imageView.image = UIImage(named: "defaultImage")
            writingManager.imageType = .basic
            writingManager.imageUUID = nil
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
