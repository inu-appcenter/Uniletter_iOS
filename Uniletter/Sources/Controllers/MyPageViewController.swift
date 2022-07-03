//
//  MyPageViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/06/29.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {
    
    // test
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let infoView: UIView = {
       
        let view = UIView()
        
    
        return view
        
    }()
    
    let userImage: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "UserImage")
        imageView.clipsToBounds = true
        
        imageView.layer.borderWidth = 0.3
        imageView.layer.cornerRadius = 38
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()

        label.text = "사용자"
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let grayBar: UIView = {
        let view = UIView()

        view.backgroundColor = UIColor.customColor(.lightGray)
        
        return view
    }()

    let changeBtn: UIButton = {

        var config = UIButton.Configuration.plain()
        
        var titleArr = AttributedString.init("수정하기")
        titleArr.font = .systemFont(ofSize: 13)
        config.attributedTitle = titleArr
        
        var btn = UIButton(configuration: config)
        btn.tintColor = UIColor.customColor(.lightGray)
        
        btn.addTarget(self, action: #selector(changeBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    let saveListBtn: UIButton = {
        
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.image = UIImage(systemName: "bookmark.fill")
        config.imagePadding = 10
        config.imagePlacement = .leading
        
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.tintColor = UIColor.customColor(.yellow)
        button.setTitle("저장목록", for: .normal)
        
        return button
    }()
    
    let alarmListBtn: UIButton = {
        
        var config = UIButton.Configuration.plain()
        config.baseBackgroundColor = .clear
        config.image = UIImage(systemName: "bell.fill")
        config.imagePadding = 10
        config.imagePlacement = .leading
        
        let button = UIButton(configuration: config)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.tintColor = UIColor.customColor(.yellow)
        button.setTitle("알림목록", for: .normal)
        
        return button
    }()
    
    var myPageViewModel = MyPageViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
    }
 
    
    func configureUI() {

        view.addSubview(scrollView)

        scrollView.addSubview(infoView)
        
        infoView.addSubview(tableView)
        infoView.addSubview(userImage)
        infoView.addSubview(userName)
        infoView.addSubview(grayBar)
        infoView.addSubview(changeBtn)
        infoView.addSubview(saveListBtn)
        infoView.addSubview(alarmListBtn)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPageCell.self, forCellReuseIdentifier: MyPageCell.identifier)
        tableView.register(MyPageSectionView.self, forHeaderFooterViewReuseIdentifier: MyPageSectionView.identifier)
        
        scrollView.snp.makeConstraints {

            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view)
            $0.width.equalTo(350)
            $0.height.equalTo(800)
        }

        infoView.snp.makeConstraints {

            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(850)
            $0.width.equalTo(scrollView.snp.width)
        }

        userImage.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(36)
            $0.centerX.equalTo(scrollView)
            $0.width.height.equalTo(78)
        }

        userName.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(24)
            $0.centerX.equalTo(infoView)
        }

        grayBar.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom).offset(4)
            $0.centerX.equalTo(infoView)
            $0.width.equalTo(244)
            $0.height.equalTo(0.5)
        }

        changeBtn.snp.makeConstraints {
            $0.top.equalTo(grayBar.snp.bottom).offset(4)
            $0.centerX.equalTo(infoView)
        }
        
        saveListBtn.snp.makeConstraints {
            $0.top.equalTo(changeBtn.snp.bottom).offset(16)
            $0.leading.equalTo(view.snp.centerX).offset(-160)
            $0.width.equalTo(160)
            $0.height.equalTo(49)
        }
        
        alarmListBtn.snp.makeConstraints {
            $0.top.equalTo(changeBtn.snp.bottom).offset(16)
            $0.leading.equalTo(saveListBtn.snp.trailing)
            $0.width.equalTo(160)
            $0.height.equalTo(49)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(saveListBtn.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(scrollView)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNavigationBar() {
        let logo = UIBarButtonItem(
            image: UIImage(named: "Vector")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(backBtnClicked))
        self.navigationItem.leftBarButtonItem = logo
        
        self.navigationItem.title = "나의 레터"
    }
    
    @objc func backBtnClicked() {
        self.navigationController?.popViewController(animated: true)
        print("backBtnClicked - called")
    }
    
    @objc func changeBtnClicked(_ sender: UIGestureRecognizer) {
        print("changeBtnClicked() - called")
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return myPageViewModel.numOfSection
    }
    

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        guard let headerView = view as? MyPageSectionView else { return }
        

        switch section {
        case 0:
            headerView.updateUI(myPageViewModel.titleOfSection(at: section))
        case 1:
            headerView.updateUI(myPageViewModel.titleOfSection(at: section))
        case 2:
            headerView.updateUI(myPageViewModel.titleOfSection(at: section))
        case 3:
            headerView.updateUI(myPageViewModel.titleOfSection(at: section))
        default:
            print("error")
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageSectionView.identifier)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return myPageViewModel.numOfCell(at: 0)
        case 1:
            return myPageViewModel.numOfCell(at: 1)
        case 2:
            return myPageViewModel.numOfCell(at: 2)
        case 3:
            return myPageViewModel.numOfCell(at: 3)
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCell.identifier, for: indexPath) as? MyPageCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            let text = myPageViewModel.type[indexPath.section].cell
            cell.updateUI(at: text[indexPath.row])
            return cell
        case 1:
            let text = myPageViewModel.type[indexPath.section].cell
            cell.updateUI(at: text[indexPath.row])
            return cell
        case 2:
            let text = myPageViewModel.type[indexPath.section].cell
            cell.updateUI(at: text[indexPath.row])
            return cell
        case 3:
            let text = myPageViewModel.type[indexPath.section].cell
            cell.updateUI(at: text[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}
