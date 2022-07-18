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
    
    func changeCheckButton(_ bool: Bool) {
        writingManager.basicImage = bool
        
        let button = writingPictureView.checkView.checkButton
        if bool {
            button.layer.borderColor = CGColor.customColor(.blueGreen)
            button.backgroundColor = UIColor.customColor(.blueGreen)
            
            writingPictureView.imageButton.setImage(
                UIImage(named: "UniletterLabel"),
                for: .normal)
        } else {
            button.layer.borderColor = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1).cgColor
            button.backgroundColor = .white
        }
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
        
        changeCheckButton(sender.isSelected)
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
                self.writingManager.basicImage = false
                self.writingManager.setImage(image as! UIImage)
                
                DispatchQueue.main.async {
                    self.writingPictureView.imageButton.setImage(
                        image as? UIImage,
                        for: .normal)
                    
                    self.writingPictureView.checkView.checkButton.isSelected = false
                    self.changeCheckButton(false)
                }
            }
        }
    }
}
