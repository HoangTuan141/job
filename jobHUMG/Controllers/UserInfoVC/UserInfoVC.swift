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
    var userId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo(id: userId)
    }
    
    func getUserInfo(id: Int) {
        GetUserInfoAPI(id: id).excute(target: self, success: { [weak self] response in
            if let data = response?.data {
                self?.nameLabel.text = data.fullName
                self?.careerLabel.text = data.career
                self?.introduceLabel.text = data.introduce
                self?.fullNameLabel.text = data.fullName
                self?.birthdayLabel.text = data.birthday
                self?.phoneNumberLabel.text = data.phoneNumber
                self?.skypeLabel.text = data.skype
                self?.emailLabel.text = data.email
                self?.maritalStatusLabel.text = data.marital
                self?.hobbyLabel.text = data.hobby
            } else {
                self?.showAlert(title: "Lỗi", subTitle: "Đã có lỗi xảy ra. Vui lòng thử lại", titleButton: "OK", completion: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
            
        }, error: { error in
            self.showAlert(title: "Lỗi", subTitle: "Đã có lỗi xảy ra. Vui lòng thử lại", titleButton: "OK", completion: {
                self.navigationController?.popViewController(animated: true)
            })
        })
    }

    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
