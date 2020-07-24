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
        if emailTextField.text == "" || passwordTextField.text == "" || firstNameTextField.text == "" || lastNameTextField.text == "" {
            self.showAlert(title: "Lỗi", subTitle: "Vui lòng không để trống thông tin", titleButton: "OK") {
                return
            }
        }
        
        if passwordTextField.text!.count < 6 {
            self.showAlert(title: "Lỗi", subTitle: "Mật khẩu phải lớn hơn hoặc bằng 6 ký tự", titleButton: "OK") {
                return
            }
        }
        
        if !emailTextField.text!.isEmail {
            self.showAlert(title: "Lỗi", subTitle: "Vui lòng nhập đúng định dạng email", titleButton: "OK") {
                return
            }
        }
        
        RegisterAPI(email: emailTextField.text!, password: passwordTextField.text!, firstName: firstNameTextField.text!, lastName: lastNameTextField.text!).excute(target: self, success: { [weak self] response in
            self?.showAlert(title: "Thành công", subTitle: "Bạn đã đăng ký tài khoản thành công", titleButton: "OK", completion: {
                self?.navigationController?.popViewController(animated: true)
            })
        }, error: { [weak self] error in
            self?.showAlert(title: "Lỗi", subTitle: "Đăng ký tài khoản không thành  . Vui lòng thử lại", titleButton: "OK", completion: nil)
        })
    }
    
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField || textField == passwordTextField || textField == lastNameTextField || textField == firstNameTextField{
            textField.resignFirstResponder()
        }
        return true
    }
}
