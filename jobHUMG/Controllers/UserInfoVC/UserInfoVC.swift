//
//  UserInfoVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 7/1/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var careerLabel: UILabel!
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var skypeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var maritalStatusLabel: UILabel!
    @IBOutlet weak var hobbyLabel: UILabel!
    
    // MARK: - Variable
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
