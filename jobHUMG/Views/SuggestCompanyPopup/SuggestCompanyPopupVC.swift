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
    
    var suggestCompanySuccess: (() -> Void)?
    var suggestCompanyFailed: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func suggestCompany(companyName: String, address: String, career: String) {
        SuggestCompanyAPI(name: companyName, address: address, career: career).excute(target: self, success: { response in
            self.suggestCompanySuccess?()
            self.dismiss(animated: false, completion: nil)
        }, error: { error in
            self.suggestCompanyFailed?()
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func suggestPressed(_ sender: Any) {
        if addressTextField.text!.isEmpty || carrerTextField.text!.isEmpty || companyNameTextField.text!.isEmpty {
            self.showAlert(title: "Không thể tạo gợi ý công ty", subTitle: "Vui lòng điền đầy đủ thông tin. Không được để trống.", titleButton: "OK", completion: nil)
        } else {
            suggestCompany(companyName: companyNameTextField.text!, address: addressTextField.text!, career: carrerTextField.text!)
        }
    }
    
 

}
