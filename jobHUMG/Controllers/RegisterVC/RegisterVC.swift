//
//  RegisterVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/3/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    //MARK: - OUTLET
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    
    private var isSelectedPolicy = false
    //MARK: LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    //MARK: - FUNCTION
    private func setupView() {
        self.endEditting()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        lastNameTextField.delegate = self
        firstNameTextField.delegate = self
    }
    
    //MARK: - ACTION
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        RegisterAPI(email: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!).excute(target: self, success: { [weak self] response in
        }, error: { [weak self] error in
            
        })
    }
    
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            lastNameTextField.becomeFirstResponder()
        } else if textField == lastNameTextField {
            firstNameTextField.becomeFirstResponder()
        } else if textField == firstNameTextField {
            firstNameTextField.resignFirstResponder()
        }
        return true
    }
}
