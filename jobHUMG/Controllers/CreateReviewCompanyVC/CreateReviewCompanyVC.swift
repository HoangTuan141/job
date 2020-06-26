//
//  CreatReviewCompanyVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/13/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit
import Cosmos

class CreateReviewCompanyVC: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var heightReviewTextView: NSLayoutConstraint!
    @IBOutlet weak var reviewTextView: PlaceholderTextView!
    
    // MARK: - Variable
    var id: Int = 0
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.endEditting()
        setupView()
        setupTextView()
    }
    
    // MARK: - Method
    private func setupView() {
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
        ratingView.isUserInteractionEnabled = true
    }
    
    private func setupTextView() {
        reviewTextView.placeholder = "Nhập review của bạn"
        reviewTextView.heightDidChange = { [weak self] height in
            self?.heightReviewTextView.constant = height > 33 ? height : 33
        }
    }
    
    private func createReview(name: String, content: String, id: Int, star: Int) {
        CreateReviewAPI(name: name, content: content, id: id, star: star).excute(target: self, success: { [weak self] response in
            print(response)
            self?.navigationController?.popViewController(animated: true)
        }, error: { [weak self] error in
            self?.showAlert(title: "Lỗi tạo review", subTitle: "Đã có lỗi xảy ra. Vui lòng thử lại", titleButton: "OK", completion: nil)
        })
    }
    
    
    // MARK: - Action

    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func postPressed(_ sender: Any) {
        if nameTextField.text!.isEmpty || reviewTextView.textView.text!.isEmpty {
            self.showAlert(title: "Không thể tạo review", subTitle: "Không được bỏ trống tên hoặc nội dung review", titleButton: "OK", completion: nil)
        } else {
            createReview(name: nameTextField.text!, content: reviewTextView.textView.text, id: self.id, star: Int(ratingView.rating))
        }
    }
    
    

}
