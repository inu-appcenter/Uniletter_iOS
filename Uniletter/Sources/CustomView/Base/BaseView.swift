//
//  BaseView.swift
//  Uniletter
//
//  Created by 권오준 on 2022/12/05.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        configureView()
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configureView() {
        // override 후, 원하는 작업 추가
    }
    
    func configureUI() {
        // override 후, UI 컴포넌트들 addSubView
    }
    
    func configureLayout() {
        // override 후, UI 컴포넌트들 레이아웃 추가
    }
}
