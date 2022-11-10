//
//  MyPageViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/06/29.
//

import UIKit
import SnapKit
import Kingfisher

final class MyPageViewController: UIViewController {

    var myPageManager = MyPageManager.shared
    var loginManager = LoginManager.shared
    var logoutCompletionClosure: (() -> Void)?

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
        
        imageView.clipsToBounds = true
        
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 38
        imageView.layer.borderColor = UIColor.customColor(.darkGray).cgColor

        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let grayBar: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.customColor(.lightGray)
        
        return view
    }()
    
    lazy var changeButton: UIButton = {
        
        var config = UIButton.Configuration.plain()
        
        var titleArr = AttributedString.init("수정하기")
        titleArr.font = .systemFont(ofSize: 13)
        config.attributedTitle = titleArr
        
        let btn = UIButton(configuration: config)
        btn.tintColor = UIColor.customColor(.lightGray)
        btn.addTarget(self, action: #selector(changeBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    lazy var saveListButton: UIButton = {
        
        let button = UIButton()
        button.listButtonSetting("bookmark.fill", "저장목록")
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        button.addTarget(self, action: #selector(saveListButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var alarmListButton: UIButton = {
        
        let button = UIButton()
        button.listButtonSetting("bell.fill", "알림목록")
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        button.addTarget(self, action: #selector(alarmListButtonClicked(_:)), for: .touchUpInside)
        return button
        
    }()
    
    lazy var deleteAccountButton: UIButton = {
        
        var config = UIButton.Configuration.plain()
        var attribute = AttributedString.init("탈퇴하기")
        attribute.font = .systemFont(ofSize: 13)
        attribute.underlineStyle = NSUnderlineStyle.single
        config.attributedTitle = attribute

        let button = UIButton()
        button.tintColor = UIColor.customColor(.lightGray)
        button.configuration = config
        
        button.addTarget(self, action: #selector(deleteAccountButtonClicked(_:)), for: .touchUpInside)
        return button
        
    }()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        fetchUserInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userName.text = myPageManager.userName
        userImage.image = myPageManager.userImage
    }


    func fetchUserInfo() {
        self.myPageManager.setUserInfo {
            self.myPageManager.setUserImage { image in
                DispatchQueue.main.async {
                    self.userImage.image = image
                    self.userName.text = self.myPageManager.setUserNickName()
                }
            }
        }
    }
    
    func configureUI() {
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(infoView)
        
        [
            tableView,
            userImage,
            userName,
            grayBar,
            changeButton,
            saveListButton,
            alarmListButton,
            deleteAccountButton
        ]
            .forEach { infoView.addSubview($0) }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyPageCell.self, forCellReuseIdentifier: MyPageCell.identifier)
        tableView.register(MyPageSectionView.self, forHeaderFooterViewReuseIdentifier: MyPageSectionView.identifier)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.height.equalTo(view)
        }
        
        infoView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(880)
            $0.width.equalTo(scrollView)
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
            $0.leading.equalToSuperview().offset(70)
            $0.trailing.equalToSuperview().offset(-70)
            $0.height.equalTo(0.5)
        }
        
        changeButton.snp.makeConstraints {
            $0.top.equalTo(grayBar.snp.bottom).offset(4)
            $0.centerX.equalTo(infoView)
        }
        
        saveListButton.snp.makeConstraints {
            $0.top.equalTo(changeButton.snp.bottom).offset(16)
            $0.leading.equalTo(view.snp.centerX).offset(-160)
            $0.width.equalTo(160)
            $0.height.equalTo(49)
        }
        
        alarmListButton.snp.makeConstraints {
            $0.top.equalTo(changeButton.snp.bottom).offset(16)
            $0.leading.equalTo(saveListButton.snp.trailing)
            $0.width.equalTo(160)
            $0.height.equalTo(49)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(saveListButton.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(scrollView)
            $0.height.equalTo(480)
        }
        
        deleteAccountButton.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.leading.equalToSuperview().offset(20)
        }
        
        deleteAccountButton.titleLabel!.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("나의 레터")
    }
    
    @objc func changeBtnClicked(_ sender: UIGestureRecognizer) {
        let view = ChangeViewController()
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func saveListButtonClicked(_ sender: UIGestureRecognizer) {
        let view = SaveListViewController()
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func alarmListButtonClicked(_ sender: UIGestureRecognizer) {
        let view = NotiListViewController()
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    @objc func deleteAccountButtonClicked(_ sender: UIGestureRecognizer) {
        
        let firstNoticeVC = getNoticeAlertVC(noticeAlert: .deleteAccountFirst, check: true)
        
        present(firstNoticeVC, animated: true)

        firstNoticeVC.okButtonCompletionClosure = {
            let secondNoticeVC = self.getNoticeAlertVC(noticeAlert: .deleteAccountSecond, check: true)
            
            secondNoticeVC.okButtonCompletionClosure = {
                // TODO: 회원탈퇴 처리
                
                self.myPageManager.deleteAccount {
                    self.loginManager.logout()
                    self.goToInitialViewController()
                }
            }
            self.present(secondNoticeVC, animated: true)
        }
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myPageManager.numOfSection
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        guard let headerView = view as? MyPageSectionView else { return }
        
        headerView.updateUI(myPageManager.titleOfSection(at: section))
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MyPageSectionView.identifier)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageManager.numOfCell(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageCell.identifier, for: indexPath) as? MyPageCell else { return UITableViewCell() }
        
        let text = myPageManager.type[indexPath.section].cell
        cell.updateUI(at: text[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.section == 3 && indexPath.row == 0 {
            LoginManager.shared.logout()
            
            self.navigationController?.popToRootViewController(animated: true)
            
            if let logoutCompletionClosure = logoutCompletionClosure {
                logoutCompletionClosure()
            }
            
        } else {

            let pushView = myPageManager.viewOfSection(indexPath.section, indexPath.row)
            
            self.navigationController?.pushViewController(pushView, animated: true)
        }
    }
}
