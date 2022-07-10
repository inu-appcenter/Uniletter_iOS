//
//  MyCommentViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/08.
//

import UIKit
import SnapKit

class MyCommentViewController: UIViewController {
    
    let myCommentViewModel = MyCommentViewModel()
    
    lazy var collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MyCommentCell.self, forCellWithReuseIdentifier: MyCommentCell.identifier)
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationBar()
        configureUI()
        settingAPI()
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("댓글 단 글")
    }
    
    func configureUI() {
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func settingAPI() {

        self.myCommentViewModel.getMyComments {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

extension MyCommentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myCommentViewModel.numOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCommentCell.identifier, for: indexPath) as? MyCommentCell else { return UICollectionViewCell() }
        
        cell.setUI(event: myCommentViewModel.events[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let EventDetailVC = EventDetailViewController()
        
        EventDetailVC.id = myCommentViewModel.events[indexPath.row].id
        
        navigationController?.pushViewController(EventDetailVC, animated: true)
    }
}

extension MyCommentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
    }
}
