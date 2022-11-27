//
//  CategoryButton.swift
//  Uniletter
//
//  Created by 권오준 on 2022/11/28.
//

import UIKit

final class CategoryButton: UIButton {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        changeCornerRadius()
    }

    // MARK: - Setup
    
    func configureButton(_ title: String) {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .trailing
        config.imagePadding = 5
        
        configuration = config
        layer.borderWidth = 1
        layer.borderColor = .customColor(.deepLightGray)
        
        setTitleColor(.black, for: .normal)
        setTitleColor(.white, for: .selected)
        titleLabel?.font = .systemFont(ofSize: 11, weight: .medium)
        setAttributedTitle(title.changeAttributed(false), for: .normal)
        setAttributedTitle(title.changeAttributed(true), for: .selected)
        clipsToBounds = true
        
        changeState(false)
    }
    
    // MARK: - Func
    
    func changeCornerRadius() {
        layer.cornerRadius = frame.height / 2
        layer.cornerCurve = .circular
    }
    
    func changeState(_ isSelected: Bool) {
        backgroundColor = isSelected ? .customColor(.lightBlueGreen) : .white
    }
    
}
