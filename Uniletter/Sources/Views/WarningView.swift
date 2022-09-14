//
//  WarningView.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/20.
//
import UIKit
import SnapKit

class WarningView: UIView {

    var subView: UIView = {
        let view = UIView()

        view.backgroundColor = .black.withAlphaComponent(0.6)
        view.layer.cornerRadius = 25

        return view
    }()

    var warninglabel: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 16)
        label.textColor = .white

        label.text = "댓글은 300자 이내로 입력가능합니다."
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
        addSubview(subView)
        subView.addSubview(warninglabel)
        
        let height = UIScreen.main.bounds.height / 3
        
        subView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(height)
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }

        warninglabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
