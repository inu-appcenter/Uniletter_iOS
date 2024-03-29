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
    let notiCenter = UNUserNotificationCenter.current()
    
    var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        

        
        collectionView.register(NewNoticeCell.self, forCellWithReuseIdentifier: NewNoticeCell.identifier)
        
        return collectionView
    }()

    lazy var notificationButton: UIButton = {
        let button = UIButton()
        button.createCompletionButton("선택 완료")
        
        button.addTarget(self, action: #selector(doneButtonclicked), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
            
        configureNavigationBar()
        setting()
        
        DispatchQueue.main.async {
            self.viewModel.setTopic {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setting() {
        
        [ collectionView, notificationButton ] .forEach { view.addSubview($0) }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(notificationButton.snp.top).offset(-20)
        }
        
        notificationButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-15)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    func configureNavigationBar() {
        setNavigationTitleAndBackButton("새로운 행사 알림")
    }
    
    @objc func doneButtonclicked() {
        DispatchQueue.global().async {
            
            self.notiCenter.getNotificationSettings { settings in
                DispatchQueue.main.async {
                    switch settings.alertSetting {
                    case .enabled:
                        self.viewModel.putTopic()
                        self.navigationController?.popViewController(animated: true)
                    default:
                        let noticeAlertVC = self.getNoticeAlertVC(noticeAlert: .pushAlarm, check: false)
                        
                        self.present(noticeAlertVC, animated: true)
                        
                        noticeAlertVC.okButtonCompletionClosure = {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        }
    }
}


extension NewNoticeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewNoticeCell.identifier, for: indexPath) as? NewNoticeCell else { return UICollectionViewCell() }
        
        cell.imageView.image = viewModel.imageOfIndex(indexPath.item)
        cell.imagetitle.text = viewModel.titleOfIndex(indexPath.item)
        
        cell.cellSelected(viewModel.selected[viewModel.titleOfIndex(indexPath.item)]!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.selected[viewModel.titleOfIndex(indexPath.item)] = !viewModel.selected[viewModel.titleOfIndex(indexPath.item)]!

        
        collectionView.reloadData()
    }
}

extension NewNoticeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 20 * 2 - 16) / 2
        
        let height = width * 1.11
        
        return CGSize(width: width, height: height)
    }
    
    // 셀 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 12
    }
    
    // 셀 열 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 20, bottom: 0, right: 20)
    }
}
