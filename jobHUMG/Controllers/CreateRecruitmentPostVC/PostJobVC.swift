//
//  PostJobVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/5/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class PostJobVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var careerTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var addressTextView: PlaceholderTextView!
    @IBOutlet weak var descriptionTextView: PlaceholderTextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var heightAddressTextView: NSLayoutConstraint!
    @IBOutlet weak var heightDescriptionTextView: NSLayoutConstraint!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var startTimeRecruitmentTextField: UITextField!
    @IBOutlet weak var endTimeRecruitmentTextField: UITextField!
    
    // MARK: - Variable
    private var startTime = 1587426600
    private var endTime = 1587426600
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextField()
    }
    
    // MARK: - Method
    private func setupView() {
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
        addressTextView.placeholder = "Nhập địa chỉ công ty"
        addressTextView.heightDidChange = { [weak self] height in
            self?.heightAddressTextView.constant = height > 33 ? height : 33
            if height > 66 {
                self?.heightAddressTextView.constant = 66
            }
        }
        descriptionTextView.placeholder = "Nhập mô tả công việc"
        descriptionTextView.heightDidChange = { [weak self] height in
            self?.heightDescriptionTextView.constant = height > 33 ? height : 33
        }
    }
    
    private func setupTextField() {
        startTimeRecruitmentTextField.delegate = self
        endTimeRecruitmentTextField.delegate = self
    }
    
    private func createRecruitmentPost(career: String, companyName: String, salary: String, location: String, description: String, startTime: Int, endTime: Int) {
        CreateRecruitmentPost(carrer: career, companyName: companyName, salary: salary, location: location, description: description, startDate: startTime, endDate: endTime).excute(target: self, success: { [weak self] response in
            print("ok")
        }, error: { [weak self] error in
            
        })
    }
    
    
    // MARK: Action
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postPressed(_ sender: Any) {
        if careerTextField.text!.isEmpty || companyTextField.text!.isEmpty || salaryTextField.text!.isEmpty || addressTextView.textView.text.isEmpty || descriptionTextView.textView.text.isEmpty || startTimeRecruitmentTextField.text!.isEmpty || endTimeRecruitmentTextField.text!.isEmpty {
            
        } else {
            createRecruitmentPost(career: careerTextField.text!, companyName: companyTextField.text!, salary: salaryTextField.text!, location: addressTextView.textView.text!, description: descriptionTextView.textView.text!, startTime: self.startTime, endTime: self.endTime)
        }
    }
    
}

extension PostJobVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == startTimeRecruitmentTextField {
            self.endEditting()
            self.showDatePicker(onClickChoose: { [weak self] date in
                self?.startTimeRecruitmentTextField.text = date
                self?.startTime = Int(date.toDate(formatter: .dayMonthYear)!.millisecondsSince1970)
            })
        } else if textField == endTimeRecruitmentTextField {
            self.endEditting()
            self.showDatePicker(onClickChoose: { [weak self] date in
                self?.endTimeRecruitmentTextField.text = date
                self?.endTime = Int(date.toDate(formatter: .dayMonthYear)!.millisecondsSince1970)
            })
        }
    }
}
