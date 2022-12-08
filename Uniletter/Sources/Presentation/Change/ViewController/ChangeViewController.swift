//
//  ChangeViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/05.
//

import UIKit
import SnapKit
import PhotosUI

class ChangeViewController: UIViewController {
    
    var viewModel = ChangeViewModel()
    
    let infoView: UIView = {
       
        let view = UIView()
    

        return view
    }()
    
    lazy var userImage: UIImageView = {
        let imageView = UIImageView()

        imageView.clipsToBounds = true
        
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 38
        imageView.layer.borderColor = UIColor.customColor(.darkGray).cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    let cameraView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor.customColor(.lightGray).cgColor
        view.backgroundColor = .white
        return view
    }()
    
    lazy var changeImageButton: UIButton = {
       
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.image = UIImage(named: "camera")
        
        var button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(changeImageButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    lazy var completionButton: UIButton = {
        var button = UIButton()
        button.createCompletionButton("완료")
        button.addTarget(self, action: #selector(notificationButtonClicked), for: .touchUpInside)
        return button
    }()

    lazy var textField: UITextField = {
       
        var textField = UITextField()
        
        return textField
    }()
    
    lazy var warningLabel: UILabel = {
       
        var label = UILabel()
        
        label.text = "최대 8글자까지 입력 가능합니다"
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .red
        label.isHidden = true
        return label
        
    }()
    
    lazy var border: CALayer = {
       
        var border = CALayer()
        border.backgroundColor = UIColor.customColor(.lightGray).cgColor
        
        return border
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        setUserInfo()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: textField)
    }

    override func viewDidLayoutSubviews() {
        settingTextField()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
    }

    func setUserInfo() {
        DispatchQueue.main.async {
            self.textField.text = self.viewModel.userName
            self.userImage.image = self.viewModel.userImage
        }
    }
    
    func settingTextField() {
        textField.borderStyle = .none
        border.frame = CGRect(x: 0, y: textField.frame.size.height + 3, width: textField.frame.size.width, height: 1)
        textField.layer.addSublayer(border)
        textField.textAlignment = .center
        
        let pencilImage = UIImageView()
        pencilImage.image = UIImage(systemName: "pencil")
        pencilImage.tintColor = UIColor.customColor(.lightGray)
        pencilImage.frame = CGRect(x: 0, y: 0, width: 13, height: 13)
        textField.rightView = pencilImage
        textField.rightViewMode = .always
        
        textField.tintColor = UIColor.customColor(.blueGreen)
        
        textField.delegate = self
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("프로필수정")
    }
    
    func configureUI() {
        
        view.addSubview(infoView)
        view.addSubview(completionButton)
        
        infoView.addSubview(userImage)
        infoView.addSubview(cameraView)
        infoView.addSubview(textField)
        infoView.addSubview(warningLabel)
        
        cameraView.addSubview(changeImageButton)
        
        infoView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        userImage.snp.makeConstraints {
            $0.top.equalTo(infoView).offset(36)
            $0.centerX.equalTo(infoView)
            $0.width.height.equalTo(78)
        }
        
        cameraView.snp.makeConstraints {
            $0.bottom.equalTo(userImage.snp.bottom)
            $0.leading.equalTo(userImage.snp.centerX).offset(20)
            $0.width.height.equalTo(24)
        }
        
        changeImageButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(cameraView)
        }
        
        completionButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(65)
            $0.trailing.equalToSuperview().offset(-52)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func changeImageButtonClicked() {
        
        let actionSheetViewController = ActionSheetViewController()
        actionSheetViewController.actionSheet = .modifyInfo
        actionSheetViewController.modalPresentationStyle = .overFullScreen
        actionSheetViewController.modalTransitionStyle = .crossDissolve
        
        actionSheetViewController.selectPhotoCompletionClosure = {
            var configuration = PHPickerConfiguration()
            configuration.selectionLimit = 1
            configuration.filter = .images
            
            let picker = PHPickerViewController(configuration: configuration)
            picker.delegate = self
            picker.modalPresentationStyle = .fullScreen
            
            self.present(picker, animated: true, completion: nil)
        }
        
        actionSheetViewController.basicPhotoCompletionClosure = {
            
            self.viewModel.choiceImage = UIImage(named: "UserImage")
            
            self.userImage.image = self.viewModel.choiceImage
        }
        present(actionSheetViewController, animated: true)
    }
    
    @objc func textDidChange(_ notification: Notification) {
        guard let notiTextField = notification.object as? UITextField else { return }
        
        guard let text = notiTextField.text else { return }

        if text.count < 1 {
            warningLabel.isHidden = true
            border.backgroundColor = UIColor.customColor(.darkGray).cgColor
        } else if 0 < text.count && text.count < 8 {
            warningLabel.isHidden = false
            border.backgroundColor = UIColor.customColor(.blueGreen).cgColor
        } else if text.count > 8 {
            textField.resignFirstResponder()
            let index = text.index(text.startIndex, offsetBy: 8)
            let newString = text[text.startIndex..<index]
            textField.text = String(newString)
        }
    }
    
    
    @objc func notificationButtonClicked() {
        guard let text = textField.text else { return }
      
        viewModel.changeName = text
        
        if viewModel.choiceImage == nil {
            viewModel.choiceImage = viewModel.userImage
        }
        
        if viewModel.choiceImage == UIImage(named: "UserImage") {
            self.viewModel.uploadUserInfo(self.viewModel.changeName!, nil)
        } else {
            DispatchQueue.global().async {
                self.viewModel.uploadUserInfo(self.viewModel.changeName!, self.viewModel.choiceImage!)
            }
        }

        
        navigationController?.popViewController(animated: true)
    }
}

extension ChangeViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                DispatchQueue.main.async {
                    guard let selectedImage = image as? UIImage else { return }
                    
                    self.viewModel.choiceImage = selectedImage
                    self.userImage.image = self.viewModel.choiceImage
                }
            }
        }
    }
}

extension ChangeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
