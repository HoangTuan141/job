//
//  PopupVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/5/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class PopupVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    var onClickLeft: (() -> Void)?
    var onClickRight: (() -> Void)?
    
    var titleText: String?
    var subTitle: String?
    var titleLeftButton: String?
    var titleRightButton: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
        subTitleLabel.text = subTitle
        leftButton.setTitle(titleLeftButton, for: .normal)
        rightButton.setTitle(titleRightButton, for: .normal)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(disablePopup))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func disablePopup() {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func leftPressed(_ sender: Any) {
        self.onClickLeft?()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func rightPressed(_ sender: Any) {
        self.onClickRight?()
        self.dismiss(animated: false, completion: nil)
    }
}
