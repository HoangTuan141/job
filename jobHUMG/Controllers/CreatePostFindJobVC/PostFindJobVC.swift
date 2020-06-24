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
            print(response)
        }, error: { [weak self] error in
            print(error)
        })
    }
    
    // MARK: - Action
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func postPressed(_ sender: Any) {
        createPost(career: careerTextField.text!, location: regionTextView.text!, description: descriptionTextView.textView.text, startDate: 1587426600, endDate: 1597426600)
    }
}

extension PostFindJobVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == careerTextField {
            regionTextView.textView.becomeFirstResponder()
        }
        return true
    }
}
