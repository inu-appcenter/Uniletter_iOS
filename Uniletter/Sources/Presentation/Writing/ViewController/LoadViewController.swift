//
//  LoadViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2023/02/26.
//

import UIKit

class LoadViewController: BaseViewController {

    // MARK: - Manager
    
    let wiritingManager = WritingManager.shared
    
    // MARK: - ViewModel
    
    let viewModel = LoadListViewModel()
    
    // MARK: - Properties
    
    // MARK: - UI Component
    
    let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(LoadListTableViewCell.self, forCellReuseIdentifier: LoadListTableViewCell.identifier)
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
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
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
}

// MARK: - UITableVIewDataSource
extension LoadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LoadListTableViewCell.identifier, for: indexPath) as? LoadListTableViewCell else { return UITableViewCell() }
        
        cell.updateUI(viewModel.eventForIndex(indexPath.item))
        
        cell.deleteButtonClosure = {
            self.viewModel.deleteEventForIndex(indexPath.item)
            self.tableView.reloadData()
        }
        
        return cell
    }
}
