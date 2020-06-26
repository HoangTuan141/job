//
//  EditProfileVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/19/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var introduceTextView: PlaceholderTextView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var skypeTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var hobbyTextField: UITextField!
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var careerTextField: UITextField!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var maritalLabel: UILabel!
    
    // MARK: - Property
    var maritalStatus: Marital = .none
    var isSelectedDate = false
    let userInfo = UserManager.shared.userInfo
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTextField()
        setupTextView()
    }
    
    
    // MARK: - Method
    private func setupView() {
        self.endEditting()
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
        
        if userInfo?.introduce != "" {
            introduceTextView.text = userInfo?.introduce
        }
        fullNameTextField.text = userInfo?.fullName
        phoneNumberTextField.text = userInfo?.phoneNumber
        careerTextField.text = userInfo?.career
        skypeTextField.text = userInfo?.skype
        emailTextField.text = userInfo?.email
        hobbyTextField.text = userInfo?.hobby
        
        if userInfo?.marital == "Độc thân" {
            maritalLabel.text = userInfo?.marital
            maritalLabel.textColor = .black
            maritalStatus = .single
        } else if userInfo?.marital == "Đã kết hôn" {
            maritalLabel.text = userInfo?.marital
            maritalLabel.textColor = .black
            maritalStatus = .married
        } else {
            maritalStatus = .none
            maritalLabel.text = "Nhập tình trạng hôn nhân"
            maritalLabel.textColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
        }
        
        if userInfo?.birthday == "" {
            birthdayLabel.text = "dd/MM/yyyy"
            birthdayLabel.textColor = #colorLiteral(red: 0.5960784314, green: 0.5960784314, blue: 0.5960784314, alpha: 1)
            isSelectedDate = false
        } else {
            birthdayLabel.text = userInfo?.birthday
            birthdayLabel.textColor = .black
            isSelectedDate = true
        }
    }
    
    private func setupTextView() {
        introduceTextView.placeholder = "Nhập giới thiệu bản thân"
    }
    
    private func setupTextField() {
        fullNameTextField.delegate = self
        phoneNumberTextField.delegate = self
        skypeTextField.delegate = self
        emailTextField.delegate = self
        hobbyTextField.delegate = self
    }
    
    @IBAction func birthdayPressed(_ sender: Any) {
        self.dismissKeyboard()
        self.showDatePicker(onClickChoose: { [weak self] date in
            self?.birthdayLabel.text = date
            self?.birthdayLabel.textColor = .black
            self?.isSelectedDate = true
        })
    }
    
    @IBAction func maritalPressed(_ sender: Any) {
        self.dismissKeyboard()
        self.showMaritalPopup(status: maritalStatus, completion: { [weak self] status in
            self?.maritalStatus = status
            self?.maritalLabel.text = status.titleString
            self?.maritalLabel.textColor = .black
        })
    }    
    
    @IBAction func updatePressed(_ sender: Any) {
        if introduceTextView.text == userInfo?.introduce &&
            fullNameTextField.text == userInfo?.fullName &&
            phoneNumberTextField.text == userInfo?.phoneNumber &&
            careerTextField.text == userInfo?.career &&
            skypeTextField.text == userInfo?.skype &&
            emailTextField.text == userInfo?.email &&
            hobbyTextField.text == userInfo?.hobby &&
            maritalLabel.text == "Nhập tình trạng hôn nhân" &&
            birthdayLabel.text == "dd/MM/yyyy" {
            self.showAlert(title: "Không thể cập nhật", subTitle: "Bạn chưa cập nhật thông tin mới nào. Vui lòng thử lại.", titleButton: "OK", completion: nil)
        } else if  fullNameTextField.text!.isEmpty ||
                    phoneNumberTextField.text!.isEmpty ||
                    careerTextField.text!.isEmpty ||
                    skypeTextField.text!.isEmpty ||
                    emailTextField.text!.isEmpty ||
                    hobbyTextField.text!.isEmpty ||
                    maritalLabel.text == "Nhập tình trạng hôn nhân" ||
                    birthdayLabel.text == "dd/MM/yyyy" {
            self.showAlert(title: "Không thể cập nhật", subTitle: "Vui lòng điền đầy đủ thông tin trước khi cập nhật", titleButton: "OK", completion: nil)
        } else {
            UpdateUserInfoAPI(fullName: fullNameTextField.text!, birthday: birthdayLabel.text!, phone: phoneNumberTextField.text!, skype: skypeTextField.text!, marital: maritalLabel.text!, hobby: hobbyTextField.text!, avatar: nil, career: careerTextField.text!, introduce: introduceTextView.textView.text).excute(target: self, success: { [weak self] response in
                print("thanh cong")
                self?.navigationController?.popViewController(animated: true)
            }, error: { error in
                self.showAlert(title: "Lỗi cập nhật", subTitle: "Đã có lỗi xảy ra. Vui lòng thử lại", titleButton: "OK", completion: nil)
            })
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditProfileVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullNameTextField ||
            textField == phoneNumberTextField ||
            textField == skypeTextField ||
            textField == emailTextField ||
            textField == hobbyTextField ||
            textField == careerTextField  {
            textField.resignFirstResponder()
        }
        return true
    }
}
