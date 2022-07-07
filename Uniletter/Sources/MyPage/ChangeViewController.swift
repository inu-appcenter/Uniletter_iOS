//
//  ChangeViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/05.
//

import UIKit
import SnapKit

class ChangeViewController: UIViewController {
    
    let infoView: UIView = {
       
        let view = UIView()
    

        return view
    }()
    
    let userImage: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "UserImage")
        imageView.clipsToBounds = true
        
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 38
        imageView.layer.borderColor = UIColor.customColor(.darkGray).cgColor
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
        config.image = UIImage(named: "Camera")
        
        var button = UIButton()
        button.configuration = config
        button.addTarget(self, action: #selector(changeImageButtonClicked), for: .touchUpInside)
        
        return button
    }()
    
    lazy var notificationButton: UIButton = {
        var button = UIButton()
        button.createNofiButton("완료")
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

        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: textField)
    }
    
    override func viewDidLayoutSubviews() {
        settingTextField()
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

    }
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("프로필수정")
    }
    
    func configureUI() {
        
        view.addSubview(infoView)
        view.addSubview(notificationButton)
        
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
        
        notificationButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        textField.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(65)
            $0.trailing.equalToSuperview().offset(-65)
        }
        
        warningLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
        }
    }
    
    @objc func changeImageButtonClicked() {
        print("changeImageButton - clicked")
    }
    
    @objc func textDidChange(_ notification: Notification) {
        guard let notiTextField = notification.object as? UITextField else { return }
        
        guard let text = notiTextField.text else { return }
        
        if text.count < 1 {
            warningLabel.isHidden = true
            border.backgroundColor = UIColor.customColor(.darkGray).cgColor
        } else {
            warningLabel.isHidden = false
            border.backgroundColor = UIColor.customColor(.blueGreen).cgColor
        }
    }
    
    @objc func notificationButtonClicked() {
        guard let text = textField.text else { return }
       

        let data: [String: Any] = [
                                    "nickname": text,
                                    "imageUrl": "null"
                                ]
        
        DispatchQueue.global().sync {
            API.patchMeInfo(data: data)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
