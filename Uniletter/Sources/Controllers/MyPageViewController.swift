//
//  MyPageViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/06/29.
//

import UIKit
import SnapKit

class MyPageViewController: UIViewController {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let infoView: UIView = {
       
        let view = UIView()
        return view
        
    }()
    
    let userImage: UIImageView = {
        let imageView = UIImageView()

        imageView.image = UIImage(named: "UserImage")
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let userName: UILabel = {
        let label = UILabel()

        label.text = "사용자"
        label.font = UIFont(name: "Noto Sans KR", size: 16)
        
        return label
    }()
    
    let grayBar: UIView = {
        let view = UIView()

        view.backgroundColor = #colorLiteral(red: 0.918249011, green: 0.9182489514, blue: 0.9182489514, alpha: 1)
        
        return view
    }()

    let changeBtn: UIButton = {

        var config = UIButton.Configuration.plain()

        let btn = UIButton()
        
        btn.configuration = config
        btn.setTitle("수정하기", for: .normal)
        btn.tintColor = #colorLiteral(red: 0.918249011, green: 0.9182489514, blue: 0.9182489514, alpha: 1)
        
        btn.addTarget(self, action: #selector(changeBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
    }
 
    
    func configureUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(infoView)
        
        infoView.addSubview(userImage)
        infoView.addSubview(userName)
        infoView.addSubview(grayBar)
        infoView.addSubview(changeBtn)
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view).offset(10)
            $0.width.equalTo(350)
            $0.height.equalTo(1500)
        }
        
        infoView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(300)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        userImage.snp.makeConstraints {
            $0.top.equalTo(scrollView).inset(36)
            $0.centerX.equalTo(scrollView)
            $0.width.height.equalTo(78)
        }
        
        userName.snp.makeConstraints {
            $0.top.equalTo(userImage.snp.bottom).offset(24)
            $0.centerX.equalTo(scrollView)
        }
        
        grayBar.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom).offset(4)
            $0.centerX.equalTo(scrollView)
            $0.width.equalTo(244)
            $0.height.equalTo(1)
        }
        
        changeBtn.snp.makeConstraints {
            $0.top.equalTo(grayBar.snp.bottom).offset(4)
            $0.centerX.equalTo(scrollView)
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
