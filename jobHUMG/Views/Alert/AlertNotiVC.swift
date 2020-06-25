//
//  AlertNotiVC.swift
//  jobHUMG
//
//  Created by hoang.anh.tuanb on 6/25/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class AlertNotiVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    var titleAlert: String = ""
    var subTitle: String = ""
    var titleButton: String = ""
    
    var onTapButton: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleAlert
        subTitleLabel.text = subTitle
        button.setTitle(titleButton, for: .normal)
       
    }

    @IBAction func buttonPressed(_ sender: Any) {
        self.onTapButton?()
        self.dismiss(animated: false, completion: nil)
    }
}
