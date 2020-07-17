//
//  ProfileVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/3/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit
import Alamofire

class ProfileVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var userInfo: DataUserInformation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserInformation()
    }
    
    private func setupTableView() {
        if let info = UserManager.shared.userInfo {
            self.userInfo = info
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1500
        tableView.registerNibCellFor(type: ProfileTableViewCell.self)
        tableView.registerNibCellFor(type: RecruitmentCell.self)
    }
    
    private func getUserInformation() {
        GetUserInformationAPI().excute(target: self, success: { [weak self] response in
            guard let data = response?.data else { return }
            UserManager.shared.saveUserInfo(data: data)
            self?.userInfo = UserManager.shared.userInfo
            self?.tableView.reloadData()
        }, error: { error in
        })
    }
}
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        if let info = self.userInfo {
            cell.fillData(userInfo: info)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension ProfileVC: ProfileTableViewCellDelegate {
    func onClickLogOut() {
        SharedData.account = ""
        SharedData.password = ""
        let loginVC = LoginVC()
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.isNavigationBarHidden = true
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = navigationController
        appDelegate?.window?.makeKeyAndVisible()
    }
    
    func onClickEditProfile() {
        let editProfileVC = EditProfileVC()
        editProfileVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
}
