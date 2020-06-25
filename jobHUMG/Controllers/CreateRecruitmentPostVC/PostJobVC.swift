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
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    
    // MARK: - Variable
    private var startTime = 1587426600
    private var endTime = 31536000
    private var isSelectedStartTime = false
    private var isSelectedEndTime = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextField()
        self.endEditting()
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
        salaryTextField.delegate = self
        careerTextField.delegate = self
        companyTextField.delegate = self
    }
    
    private func createRecruitmentPost(career: String, companyName: String, salary: String, location: String, description: String, startTime: Int, endTime: Int) {
        CreateRecruitmentPost(carrer: career, companyName: companyName, salary: salary, location: location, description: description, startDate: startTime, endDate: endTime).excute(target: self, success: { [weak self] response in
            self?.navigationController?.popViewController(animated: true)
        }, error: { [weak self] error in
            self?.showAlert(title: "Không tạo được bài viết", subTitle: "Đã có lỗi xảy ra. Vui lòng thử lại.", titleButton: "OK", completion: nil)
        })
    }
    
    
    // MARK: Action
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postPressed(_ sender: Any) {
        if careerTextField.text!.isEmpty || companyTextField.text!.isEmpty || salaryTextField.text!.isEmpty || addressTextView.textView.text.isEmpty || descriptionTextView.textView.text.isEmpty || !isSelectedStartTime || !isSelectedEndTime {
            self.showAlert(title: "Không tạo được bài viết", subTitle: "Vui lòng điền đầy đủ thông tin", titleButton: "OK", completion: nil)
        } else {
            startTime = startDateButton.titleLabel?.text?.toDate(formatter: .dayMonthYear)?.timeStamp ?? 0
            endTime = endDateButton.titleLabel?.text?.toDate(formatter: .dayMonthYear)?.timeStamp ?? 0
            createRecruitmentPost(career: careerTextField.text!, companyName: companyTextField.text!, salary: salaryTextField.text!, location: addressTextView.textView.text!, description: descriptionTextView.textView.text!, startTime: self.startTime, endTime: self.endTime)
        }
    }
    
    @IBAction func startDatePressed(_ sender: Any) {
        self.endEditting()
        self.dismissKeyboard()
        self.showDatePicker(onClickChoose: { [weak self] date in
            self?.startDateButton.setTitle(date, for: .normal)
            self?.startDateButton.setTitleColor(.black, for: .normal)
            self?.isSelectedStartTime = true
        })
    }
    
    @IBAction func endDatePressed(_ sender: Any) {
        self.endEditting()
        self.dismissKeyboard()
        self.showDatePicker(onClickChoose: { [weak self] date in
            self?.endDateButton.setTitle(date, for: .normal)
            self?.endDateButton.setTitleColor(.black, for: .normal)
            self?.isSelectedEndTime = true
        })
    }
}

extension PostJobVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == salaryTextField ||  textField == careerTextField ||  textField == companyTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
