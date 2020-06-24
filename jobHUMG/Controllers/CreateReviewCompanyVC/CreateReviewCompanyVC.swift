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
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextView()
    }
    
    // MARK: - Method
    private func setupView() {
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
    }
    
    private func setupTextView() {
        reviewTextView.placeholder = "Nhập review của bạn"
        reviewTextView.heightDidChange = { [weak self] height in
            self?.heightReviewTextView.constant = height > 33 ? height : 33
        }
    }
    
    
    // MARK: - Action

    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func postPressed(_ sender: Any) {
        
    }
    
    

}
