//
//  LaunchViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import SnapKit
import Then

final class LaunchViewController: BaseViewController {

    // MARK: - UI
    
    lazy var launchLogo = UIImageView().then {
        $0.image = UIImage(named: "Logo")
        $0.contentMode = .scaleAspectFill
    }
    
    lazy var launchTitle = UILabel().then {
        $0.text = "딩동~ 유니레터가 도착했습니다~!"
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 16)
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Configure
    
    override func configureUI() {
        [launchLogo, launchTitle].forEach { view.addSubview($0) }
    }

    override func configureLayout() {
        launchLogo.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-40)
            $0.width.equalTo(150)
            $0.height.equalTo(80)
        }
        
        launchTitle.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(20)
        }
    }
}

