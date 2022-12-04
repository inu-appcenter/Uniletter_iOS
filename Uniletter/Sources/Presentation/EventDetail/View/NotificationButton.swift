//
//  NotificationButton.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/04.
//

import UIKit

enum NotiState {
    case request
    case cancel
    case done
}

final class NotificationButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func configureButton() {
        backgroundColor = UIColor.customColor(.blueGreen)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 6
    }
    
    // MARK: - Func
    
    func updateButton(_ state: NotiState) {
        switch state {
        case .request:
            backgroundColor = .customColor(.blueGreen)
            setTitle("알림 신청", for: .normal)
            setTitleColor(.white, for: .normal)
        case .cancel:
            backgroundColor = .customColor(.lightBlue)
            setTitle("알림 취소", for: .normal)
            setTitleColor(.customColor(.blueGreen), for: .normal)
        case .done:
            backgroundColor = .customColor(.lightGray)
            setTitle("마감", for: .normal)
            setTitleColor(.white, for: .normal)
        }
    }
    
}
