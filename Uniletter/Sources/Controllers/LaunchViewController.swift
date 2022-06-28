//
//  LaunchViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/27.
//

import UIKit
import SnapKit

class LaunchViewController: UIViewController {

    lazy var launchLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var launchTitle: UILabel = {
        let label = UILabel()
        label.text = "딩동~ 유니레터가 도착했습니다~!"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViews()
        setLayout()
    }
    
    func addViews() {
        [launchLogo, launchTitle].forEach { view.addSubview($0) }
    }

    func setLayout() {
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

