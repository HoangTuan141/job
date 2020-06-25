//
//  LoginVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/3/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    //MARK: - OUTLET
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerLabel: UILabel!
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - FUCTION
    private func setupView() {
        registerLabel.underlineAttribute(text: "Đăng ký")
        accountTextField.delegate = self
        passwordTextField.delegate = self
        self.endEditting()
    }
    
    //MARK: - ACTION
    @IBAction func loginPressed(_ sender: Any) {
        LoginAPI(email: accountTextField.text!, password: passwordTextField.text!).excute(target: self, success: { [weak self] response in
            self?.showLoading()
            SharedData.accessToken = response?.token
            let tabBar = TabBar()
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = tabBar
            appDelegate?.window?.makeKeyAndVisible()
        }, error: { [weak self] error in
            self?.showAlert(title: "Đăng nhập không thành công", subTitle: "Vui lòng kiểm tra lại tài khoản, mật khẩu", titleButton: "OK", completion: nil)
        })
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        let registerVC = RegisterVC()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == accountTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
