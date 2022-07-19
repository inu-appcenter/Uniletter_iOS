//
//  BlockListViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/15.
//

import UIKit
import SnapKit

class BlockListViewController: UIViewController {
    
    let blockListViewModel = BlockListViewModel()
    
    let subView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let listLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.customColor(.lightGray)
        label.text = "목록"
        return label
    }()
    
    let listCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor.customColor(.lightGray)
        label.text = "0"
        return label
    }()
    
    lazy var arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowDown"), for: .normal)
        button.setImage(UIImage(named: "arrowUp"), for: .selected)
        
        button.addTarget(self, action: #selector(arrowButtonClicked(_:)), for: .touchUpInside)
        
        return button
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        settingAPI()
    }
    
    func settingAPI() {
        DispatchQueue.main.async {
            self.blockListViewModel.getBlock {
                self.tableView.reloadData()
                self.listCountLabel.text = String(self.blockListViewModel.numOfCell)
            }
        }
    }
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("차단한 계정")
    }
    
    func configureUI() {
        view.addSubview(subView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BlockListCell.self, forCellReuseIdentifier: BlockListCell.identifier)
        
        [listLabel, listCountLabel, arrowButton, tableView]
            .forEach { subView.addSubview($0) }
        
        subView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        listLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
        
        listCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(listLabel)
            $0.leading.equalTo(listLabel.snp.trailing).offset(4)
        }
        
        arrowButton.snp.makeConstraints {
            $0.centerY.equalTo(listLabel)
            $0.leading.equalTo(listCountLabel.snp.trailing).offset(10)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(listLabel.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func postBlockNotification() {
        NotificationCenter.default.post(
            name: Notification.Name("HomeReload"),
            object: nil)
    }
    
    @objc func arrowButtonClicked(_ sender: UIGestureRecognizer) {
        arrowButton.isSelected = !arrowButton.isSelected
        tableView.isHidden = !tableView.isHidden
    }
}

extension BlockListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blockListViewModel.numOfCell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BlockListCell.identifier, for: indexPath) as? BlockListCell else { return UITableViewCell() }
        
        cell.setUI(block: blockListViewModel.blocks[indexPath.row])
        
        cell.blockCancleButtonClosure = {
            let alertViewController = self.AlertVC(.blockOff)
            self.present(alertViewController, animated: true)
            
            alertViewController.alertIsBlockOffClosure = {
                self.blockListViewModel.deleteBlock(index: indexPath.row) {
                    self.settingAPI()
                    self.postBlockNotification()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
