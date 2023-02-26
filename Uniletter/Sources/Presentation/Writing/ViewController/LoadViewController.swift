//
//  LoadViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2023/02/26.
//

import UIKit

class LoadViewController: BaseViewController {

    // MARK: - Manager
    
    // MARK: - Properties
    
    // MARK: - UI Component
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(LoadListTableViewCell.self, forCellReuseIdentifier: LoadListTableViewCell.identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    override func configureLayout() {
        
    }
    
    override func configureViewController() {
        view.backgroundColor = .white
        
    }
    
    override func configureNavigationBar() {
        setNavigationTitleAndBackButton("임시 저장 목록")
    }
}

// MARK: - UITableViewDelegate
extension LoadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

// MARK: - UITableVIewDataSource
extension LoadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadListTableViewCell.identifier, for: indexPath) as? LoadListTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
