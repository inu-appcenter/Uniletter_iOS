//
//  SearchViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/12/19.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    // MARK: - ProPerties
    
    lazy var searchBar: UISearchBar = {
        var searchBar = UISearchBar()
        
        searchBar.frame = CGRect(x: 0, y: 0, width: 250, height: 32)
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.searchTextField.font = .systemFont(ofSize: 13)
        searchBar.setImage(
            UIImage(),
            for: UISearchBar.Icon.search,
            state: .normal)
        return searchBar
    }()
    
    lazy var cancleButton = UIBarButtonItem(
        title: "취소",
        style: .done,
        target: self,
        action: #selector(cancleButtonClick))
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureNavigationBar()
    }
    
    // MARK: - Objc Functions
    
    @objc func cancleButtonClick() {
        // TODO: - 취소버튼 눌렀을 때 기능 추가
    }
}

// MARK: - Functions
extension SearchViewController {
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(searchBar)
    }
    
    func configureNavigationBar() {
        setNavigationBackButton()
        
        cancleButton.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 14),
             .foregroundColor: UIColor.customColor(.darkGray)],
            for: .normal)
        
        cancleButton.setTitleTextAttributes(
            [.font: UIFont.systemFont(ofSize: 14),
             .foregroundColor: UIColor.customColor(.darkGray)],
            for: .selected)
        
        self.navigationItem.titleView = searchBar
        self.navigationItem.rightBarButtonItem = cancleButton
    }
}
