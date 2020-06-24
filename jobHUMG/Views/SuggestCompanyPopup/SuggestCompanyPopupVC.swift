//
//  SuggestCompanyPopupVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 5/6/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class SuggestCompanyPopupVC: UIViewController {

    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var carrerTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func suggestPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
 

}
