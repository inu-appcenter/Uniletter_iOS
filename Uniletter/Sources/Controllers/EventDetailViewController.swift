//
//  EventDetailViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/06/29.
//

import UIKit

class EventDetailViewController: UIViewController {

    let eventDetailView = EventDetailView()
    let eventManager = EventManager.shared
    
    override func loadView() {
        view = eventDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setNavigationBar() {
        self.navigationItem.title = "읽어보기"
        
        let bookmarkButton = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 20))
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonDidTap(_:)), for: .touchUpInside)
        
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: 14, height: 20))
        moreButton.setImage(UIImage(systemName: "ellipsis.vertical.bubble.fill"), for: .normal)
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: moreButton),
            UIBarButtonItem(customView: bookmarkButton),
        ]
    }
    
    func setviewController() {
        
    }

    @objc func bookmarkButtonDidTap(_ sender: UIButton) {
        guard let button = self.navigationItem.rightBarButtonItems?[1] else {
            return
        }
        button.isSelected = !button.isSelected
        button.tintColor = button.isSelected
        ? UIColor.customColor(.yellow)
        : UIColor.customColor(.lightGray)
    }
}
