//
//  PrivacyPolicyViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/13.
//

import UIKit
import SnapKit

class PrivacyPolicyViewController: UIViewController {
    
    let privacyPolicyViewModel = PrivacyPolicyViewModel()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    let subView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let firstTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let firstBodyLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let secondTitleLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let secondBodyLabel: UILabel = {
        
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0

        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        setting()
    }
    
    func setting() {
        
        firstTitleLabel.text = privacyPolicyViewModel.TitleOfPolicy(policy: .first)
        firstBodyLabel.text = privacyPolicyViewModel.bodyOfPolicy(policy: .first)
        secondTitleLabel.text = privacyPolicyViewModel.TitleOfPolicy(policy: .second)
        secondBodyLabel.text = privacyPolicyViewModel.bodyOfPolicy(policy: .second)
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("개인정보 처리방침")
    }
    
    func configureUI() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(subView)
        
        [
            firstTitleLabel,
            firstBodyLabel,
            secondTitleLabel,
            secondBodyLabel
        ]
            .forEach { subView.addSubview($0) }
                
        scrollView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalTo(view)
        }
        
        subView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.height.equalTo(830)
            $0.width.equalTo(scrollView)
        }
        
        firstTitleLabel.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(24)
            $0.leading.equalTo(scrollView).offset(20)
        }
        
        firstBodyLabel.snp.makeConstraints {
            $0.top.equalTo(firstTitleLabel.snp.bottom).inset(-16)
            $0.leading.equalTo(scrollView).offset(20)
            $0.width.equalTo(view.frame.size.width - 40)
        }
        
        secondTitleLabel.snp.makeConstraints {
            $0.top.equalTo(firstBodyLabel.snp.bottom).inset(-50)
            $0.leading.equalTo(scrollView).offset(20)
        }
        
        secondBodyLabel.snp.makeConstraints {
            $0.top.equalTo(secondTitleLabel.snp.bottom).inset(-16)
            $0.leading.equalTo(scrollView).offset(20)
            $0.width.equalTo(view.frame.size.width - 40)
        }
    }
}
