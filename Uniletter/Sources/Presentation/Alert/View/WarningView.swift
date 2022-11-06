//
//  WarningView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/20.
//
import UIKit
import SnapKit

class WarningView: UIView {

    var warninglabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 16)
        label.textColor = .white

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        addSubview(warninglabel)
        backgroundColor = .black.withAlphaComponent(0.6)
        layer.cornerRadius = 25

        warninglabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
