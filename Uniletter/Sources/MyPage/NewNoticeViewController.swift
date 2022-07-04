//
//  NewNoticeViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/04.
//

import UIKit
import SnapKit

class NewNoticeViewController: UIViewController {

    let viewModel = NewNoticeViewModel()
    
    var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(NewNoticeCell.self, forCellWithReuseIdentifier: NewNoticeCell.identifier)
        
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
            
        configureNavigationBar()
        setting()
    }
    
    func setting() {
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configureNavigationBar() {
        let logo = UIBarButtonItem(
            image: UIImage(named: "Vector")?.withRenderingMode(.alwaysOriginal),
            style: .done,
            target: self,
            action: #selector(backBtnClicked))
        self.navigationItem.leftBarButtonItem = logo
        
        self.navigationItem.title = "새로운 행사 알림"
    }
    
    @objc func backBtnClicked() {
        self.navigationController?.popViewController(animated: true)
        print("backBtnClicked - called")
    }
}


extension NewNoticeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewNoticeCell.identifier, for: indexPath) as? NewNoticeCell else { return UICollectionViewCell() }
        
        cell.imageView.image = viewModel.itemOfIndex(indexPath.item)
        return cell
    }
}

extension NewNoticeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 10 // 셀 행 간격
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 10 // 셀 열 간격
    }
}
extension NewNoticeViewController {
    
}
