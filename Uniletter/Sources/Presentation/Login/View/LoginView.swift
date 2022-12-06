//
//  LoginView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/06.
//

import UIKit
import SnapKit
import Then

final class LoginView: BaseView {
    
    // MARK: - UI
    
    private let launchLogo = UIImageView().then {
        $0.image = UIImage(named: "Logo")
        $0.contentMode = .scaleAspectFill
    }
    
    private let googleLogo = UIImageView().then {
        $0.image = UIImage(named: "google")
        $0.contentMode = .scaleAspectFit
    }

    private let appleLogo = UIImageView().then {
        $0.image = UIImage(systemName: "applelogo")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    
    lazy var googleLoginButton = createLoginButton("구글 계정으로 로그인")
    
    lazy var appleLoginButton = createLoginButton("Apple로 로그인")
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureUI() {
        [
            launchLogo,
            googleLoginButton,
            appleLoginButton,
            googleLogo,
            appleLogo,
        ]
            .forEach { addSubview($0) }
    }
    
    override func configureLayout() {
        launchLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
            $0.width.height.equalTo(200)
        }
        
        googleLoginButton.snp.makeConstraints {
            $0.top.equalTo(launchLogo.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }
        
        googleLogo.snp.makeConstraints {
            $0.top.bottom.equalTo(googleLoginButton).inset(8)
            $0.left.equalTo(googleLoginButton).offset(16)
            $0.width.equalTo(appleLogo.snp.height)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.top.equalTo(googleLoginButton.snp.bottom).offset(12)
            $0.left.right.equalToSuperview().inset(40)
            $0.height.equalTo(45)
        }

        appleLogo.snp.makeConstraints {
            $0.centerY.equalTo(appleLoginButton)
            $0.left.equalTo(appleLoginButton).offset(16)
            $0.width.height.equalTo(20)
        }
    }
    
    // MARK: - Func
    
    private func createLoginButton(_ title: String) -> UIButton {
        return UIButton().then {
            $0.layer.cornerRadius = 8
            $0.layer.borderWidth = 1
            $0.layer.borderColor = .customColor(.lightGray)
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle(title, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15)
        }
    }
    
}
