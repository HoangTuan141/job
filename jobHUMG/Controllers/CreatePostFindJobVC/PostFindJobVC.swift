//
//  PostFindJobVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/5/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class PostFindJobVC: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var heightDescriptionTextView: NSLayoutConstraint!
    @IBOutlet weak var heightRegionTextView: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: PlaceholderTextView!
    @IBOutlet weak var regionTextView: PlaceholderTextView!
    @IBOutlet weak var careerTextField: UITextField!
    @IBOutlet weak var startDateButton: UIButton!
    @IBOutlet weak var endDateButton: UIButton!
    
    // MARK: - Variable
    private var startTime = 0
    private var endTime = 0
    private var isSelectedStartTime = false
    private var isSelectedEndTime = false
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlaceholderTextView()
        setupView()
    }
    
    // MARK: - Method
    private func setupPlaceholderTextView() {
        regionTextView.placeholder = "Nhập địa chỉ công ty"
        regionTextView.heightDidChange = { [weak self] height in
            self?.heightRegionTextView.constant = height > 33 ? height : 33
            if height > 66 {
                self?.heightRegionTextView.constant = 66
            }
        }
        descriptionTextView.placeholder = "Nhập mô tả công việc"
        descriptionTextView.heightDidChange = { [weak self] height in
            self?.heightDescriptionTextView.constant = height > 33 ? height : 33
        }
    }
    
    private func setupView() {
        careerTextField.delegate = self
        self.endEditting()
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
    }
    
    private func createPost(career: String, location: String, description: String, startDate: Int, endDate: Int) {
        CreatePostFindJobAPI(career: career, location: location, description: description, startDate: startDate, endDate: endDate).excute(target: self, success: { [weak self] response in
            self?.navigationController?.popViewController(animated: true)
        }, error: { [weak self] error in
            self?.showAlert(title: "Không tạo được bài viết", subTitle: "Đã có lỗi xảy ra. Vui lòng thử lại", titleButton: "OK", completion: nil)
        })
    }
    
    // MARK: - Action
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postPressed(_ sender: Any) {
        if careerTextField.text!.isEmpty || regionTextView.textView.text!.isEmpty || descriptionTextView.textView.text!.isEmpty || !isSelectedStartTime || !isSelectedEndTime {
            self.showAlert(title: "Không tạo được bài viết", subTitle: "Vui lòng điền đầy đủ thông tin. Không được để trống", titleButton: "OK", completion: nil)
        } else {
            startTime = startDateButton.titleLabel?.text?.toDate(formatter: .dayMonthYear)?.timeStamp ?? 0
            endTime = endDateButton.titleLabel?.text?.toDate(formatter: .dayMonthYear)?.timeStamp ?? 0
            createPost(career: careerTextField.text!, location: regionTextView.textView.text!, description: descriptionTextView.textView.text, startDate: startTime, endDate: endTime )
        }
    }
    
    @IBAction func startTimePressed(_ sender: Any) {
        self.endEditting()
        self.dismissKeyboard()
        self.showDatePicker(onClickChoose: { [weak self] date in
            self?.startDateButton.setTitle(date, for: .normal)
            self?.startDateButton.setTitleColor(.black, for: .normal)
            self?.isSelectedStartTime = true
        })
    }
    
    @IBAction func endTimePressed(_ sender: Any) {
        self.endEditting()
        self.dismissKeyboard()
        self.showDatePicker(onClickChoose: { [weak self] date in
            self?.endDateButton.setTitle(date, for: .normal)
            self?.endDateButton.setTitleColor(.black, for: .normal)
            self?.isSelectedEndTime = true
        })
    }
    
    @IBAction func careerbutton(_ sender: Any) {
        self.dismissKeyboard()
        self.showListCareerPopup(career: careerTextField.text!, completion: { [weak self] career in
            self?.careerTextField.text = career
        })
    }
    
}

extension PostFindJobVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == careerTextField {
            textField.resignFirstResponder()
        }
        return true
    }
}
