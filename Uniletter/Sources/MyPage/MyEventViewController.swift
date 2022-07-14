//
//  MyEventViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/13.
//

import UIKit
import SnapKit

class MyEventViewController: UIViewController {
    
    
    let myEventViewModel = MyEventViewModel()
    
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.register(MyEventCell.self, forCellWithReuseIdentifier: MyEventCell.identifier)
        
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
        setNavigationTitleAndBackButton("내가 쓴 글")
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
        
        self.myEventViewModel.getMyEvents {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension MyEventViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myEventViewModel.numOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyEventCell.identifier, for: indexPath) as? MyEventCell else { return UICollectionViewCell() }
        
        cell.setUI(event: myEventViewModel.myEvents[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let EventDetailVC = EventDetailViewController()
        
        EventDetailVC.id = myEventViewModel.myEvents[indexPath.row].id
        
        navigationController?.pushViewController(EventDetailVC, animated: true)
    }
}

extension MyEventViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 0
    }
}
