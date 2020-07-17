//
//  SplashViewController.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 7/17/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin()
    }

    
    func checkLogin() {
        if SharedData.account != "" && SharedData.account != nil && SharedData.password != ""  && SharedData.password != nil {
            LoginAPI(email: SharedData.account ?? "", password: SharedData.password ?? "").excute(target: self, success: { [weak self] response in
                self?.showLoading()
                SharedData.accessToken = response?.token
                self?.getUserInformation()
            }, error: { error in
                let vc = LoginVC()
                self.navigationController?.pushViewController(vc, animated: false)
            })
        } else {
            let vc = LoginVC()
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    private func getUserInformation() {
        GetUserInformationAPI().excute(target: self, success: { [weak self] response in
            guard let data = response?.data else { return }
            UserManager.shared.saveUserInfo(data: data)
            let tabBar = TabBar()
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = tabBar
            appDelegate?.window?.makeKeyAndVisible()
        }, error: { error in
            let vc = LoginVC()
            self.navigationController?.pushViewController(vc, animated: false)
        })
    }
}
