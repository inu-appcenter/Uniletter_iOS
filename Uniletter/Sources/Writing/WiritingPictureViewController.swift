//
//  WiritingPictureViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit
import PhotosUI

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
        writingPictureView.imageButton.addTarget(
            self,
            action: #selector(didTapImageButton(_:)),
            for: .touchUpInside)
        writingPictureView.checkView.checkButton.addTarget(
            self,
            action: #selector(didTapCheckButton(_:)),
            for: .touchUpInside)
    }

    // MARK: - Actions
    @objc func didTapImageButton(_ sender: UIButton) {
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
            writingPictureView.imageButton.setImage(
                UIImage(named: "uniletter_big"),
                for: .normal)
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
                self.writingManager.setImage(image as! UIImage)
                
                DispatchQueue.main.async {
                    self.writingPictureView.imageButton.setImage(
                        image as? UIImage,
                        for: .normal)
                    
                    self.writingPictureView.checkView.checkButton.isSelected = false
                    self.writingPictureView.checkView.checkButton.updateUI(false)
                }
            }
        }
    }
}
