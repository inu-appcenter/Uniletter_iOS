//
//  DDayButton.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/04.
//

import UIKit

final class DDayButton: UIButton {
    
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
        var config = UIButton.Configuration.filled()
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor.customColor(.blueGreen)
        config.cornerStyle = .capsule
        
        configuration = config
        clipsToBounds = true
        isUserInteractionEnabled = false
    }
    
    // MARK: - Func
    
    func updateDDay(_ endAt: String) {
        let day = endAt.caculateDateDiff()[0]
        let min = endAt.caculateDateDiff()[1]
        let dday: String
        
        if day < 0 || (day == 0 && min < 0) {
            configuration?.baseBackgroundColor = .customColor(.darkGray)
            dday = "마감"
        } else {
            configuration?.baseBackgroundColor = .customColor(.blueGreen)
            dday = day == 0 ? "D-day" : "D-\(day)"
        }
        
        var ddayAttributed = AttributedString(dday)
        ddayAttributed.font = .systemFont(ofSize: 13)
        
        configuration?.attributedTitle = ddayAttributed
    }
    
}
