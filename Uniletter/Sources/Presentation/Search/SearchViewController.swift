//
//  SearchViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/12/19.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
}

// MARK: - Functions
extension SearchViewController {
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureNavigationBar() {
        setNavigationBackButton()
    }
}
