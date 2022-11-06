//
//  LicenseViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/26.
//

import UIKit
import SnapKit

class LicenseViewController: UIViewController {
    
    let viewModel = LicenseViewModel()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("오픈소스 라이센스")
    }
    
    func configureUI() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(LicenseCell.self, forCellReuseIdentifier: LicenseCell.identifier)
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension LicenseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LicenseCell.identifier, for: indexPath) as? LicenseCell else { return UITableViewCell() }
        
        cell.label.text = viewModel.titleOfCell(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = LicenseInfoViewController()
        
        viewController.bodyLabel.text = viewModel.bodyOfCell(indexPath.row)
        
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
