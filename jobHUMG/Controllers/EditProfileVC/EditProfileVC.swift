//
//  EditProfileVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/19/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var introduceTextView: PlaceholderTextView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var skypeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var maritalStatusTextField: UITextField!
    @IBOutlet weak var hobbyTextField: UITextField!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextField()
        setupTextView()
    }
    
    private func setupView() {
        self.endEditting()
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
    }
    
    private func setupTextView() {
        introduceTextView.placeholder = "Nhập giới thiệu bản thân"
    }
    
    private func setupTextField() {
        fullNameTextField.delegate = self
        birthdayTextField.delegate = self
        phoneNumberTextField.delegate = self
        skypeTextField.delegate = self
        emailTextField.delegate = self
        maritalStatusTextField.delegate = self
        hobbyTextField.delegate = self
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTextField {
            self.dismissKeyboard()
        } else if textField == phoneNumberTextField {
            self.dismissKeyboard()
        } else if textField == skypeTextField {
            self.dismissKeyboard()
        } else if textField == emailTextField {
            self.dismissKeyboard()
        } else if textField == hobbyTextField {
            self.dismissKeyboard()
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == birthdayTextField {
            self.showDatePicker(onClickChoose: { date in
                self.birthdayTextField.text = date
            })
        }
    }
}
