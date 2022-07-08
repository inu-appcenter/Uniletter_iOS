//
//  MyCommentViewController.swift
//  Uniletter
//
//  Created by 임현규 on 2022/07/08.
//

import UIKit
import SnapKit

class MyCommentViewController: UIViewController {
    
    let myCommentViewModel = MyCommentViewModel.shared
    
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
        setting()
        settingAPI()
        print(myCommentViewModel.CommentList)
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("댓글 단 글")
    }
    
    func setting() {
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func settingAPI() {
        
        DispatchQueue.global().async {
            self.myCommentViewModel.getMyComments {
                
                
                self.myCommentViewModel.CommentList = [MyCommentList]()
                for i in 0...self.myCommentViewModel.myComments.count - 1 {
                    
                    API.getEventOne(self.myCommentViewModel.myComments[i].eventId) { Event in
                        
                        self.myCommentViewModel.events.append(Event)
                        self.myCommentViewModel.CommentList.append(MyCommentList(eventId: Event.id, eventUrl: Event.imageURL, eventTitle: Event.title, eventBody: Event.body, writeDay: Event.createdAt, commentCount: Event.comments))
                        
                        print(self.myCommentViewModel.CommentList)
                        self.collectionView.reloadData()
                    }
                }
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
        
        cell.eventImage.image = myCommentViewModel.setEventImage(imageUrl: myCommentViewModel.CommentList[indexPath.item].eventUrl)
        
        cell.eventBodyLabel.text = myCommentViewModel.CommentList[indexPath.item].eventBody
        cell.eventTitleLabel.text = myCommentViewModel.CommentList[indexPath.item].eventTitle
        cell.writeDayLabel.text = myCommentViewModel.CommentList[indexPath.item].writeDay
        cell.commentCountLabel.text = String(myCommentViewModel.CommentList[indexPath.item].commentCount)
        
        collectionView.reloadData()
        return cell
    }
}

extension MyCommentViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: 160)
    }
}
