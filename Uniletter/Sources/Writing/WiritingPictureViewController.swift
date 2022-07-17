//
//  WiritingPictureViewController.swift
//  Uniletter
//
//  Created by 권오준 on 2022/07/17.
//

import UIKit

class WiritingPictureViewController: UIViewController {

    // MARK: - Property
    let writingPictureView = WritingPictureView()
    
    // MARK: - Life cycle
    override func loadView() {
        view = writingPictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


}
