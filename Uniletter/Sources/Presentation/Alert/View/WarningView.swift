//
//  WarningView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/20.
//

import UIKit
import SnapKit
import Then

final class WarningView: BaseView {

    // MARK: - UI
    
    lazy var warninglabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .white
    }
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    override func configureView() {
        backgroundColor = .black.withAlphaComponent(0.6)
        layer.cornerRadius = 25
    }

    override func configureUI() {
        addSubview(warninglabel)
    }
    
    override func configureLayout() {
        warninglabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
