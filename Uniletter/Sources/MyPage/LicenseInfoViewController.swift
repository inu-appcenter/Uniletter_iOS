//
//  LicenseInfoViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/26.
//

import UIKit
import SnapKit

class LicenseInfoViewController: UIViewController {
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    var bodyLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("오픈소스 라이센스")
    }
    
    func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(bodyLabel)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        bodyLabel.snp.makeConstraints {            
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView)
        }
    }
}
