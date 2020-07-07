//
//  SearchRecruitmentPostVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 7/1/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class SearchRecruitmentPostVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var careerTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    // MARK: - Variable
    private var listPost = [DataListRecruitmentPost]()
    private var refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
        setupTextField()
        setupTableView()
    }
    
    // MARK: - Method
    private func setupTextField() {
        careerTextField.delegate = self
        addressTextField.delegate = self
        salaryTextField.delegate = self
        companyNameTextField.delegate = self
        descriptionTextField.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.registerNibCellFor(type: RecruitmentCell.self)
        refreshControl.addTarget(self, action: #selector(refreshListPost), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    private func searchRecruitmentPost(companyName: String?, location: String?, salary: String?, career: String?, description: String?) {
        SearchRecruitmentPostAPI(name: companyName, location: location, wage: salary, career: career, description: description).excute(target: self, success: { [weak self] response in
            self?.listPost = response!.data
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }, error: { error in
            self.refreshControl.endRefreshing()
        })
    }
    
    private func likePost(id: Int) {
        LikePostAPI(id: id).excute(target: self, success: { [weak self] response in
            self?.searchRecruitmentPost(companyName: self?.companyNameTextField.text, location: self?.addressTextField.text, salary: self?.salaryTextField.text, career: self?.careerTextField.text, description: self?.descriptionTextField.text)
        }, error: { error in
        })
    }
    
    @objc func refreshListPost() {
        searchRecruitmentPost(companyName: companyNameTextField.text, location: addressTextField.text, salary: salaryTextField.text, career: careerTextField.text, description: descriptionTextField.text)
    }

    // MARK: - Action
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectCareerPressed(_ sender: Any) {
        self.dismissKeyboard()
        self.showListCareerPopup(career: careerTextField.text!, completion: { [weak self] career in
            self?.careerTextField.text = career
            self?.searchRecruitmentPost(companyName: self?.companyNameTextField.text, location: self?.addressTextField.text, salary: self?.salaryTextField.text, career: self?.careerTextField.text, description: self?.descriptionTextField.text)
        })
    }
}

// MARK: - Extension TableView delegate, datasource
extension SearchRecruitmentPostVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecruitmentCell", for: indexPath) as! RecruitmentCell
        cell.selectionStyle = .none
        cell.fillData(data: listPost[indexPath.row])
        
        cell.tapCommentButton = { [weak self] in
            let vc = DetailPostJobVC()
            vc.id = self?.listPost[indexPath.row].id
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.tapLikeButton = { [weak self] in
            guard let strongSelf = self else { return }
            cell.setupLikeButton(isLike: !strongSelf.listPost[indexPath.row].isLike)
            let like = strongSelf.listPost[indexPath.row].likeCount
            cell.likeLabel.text = strongSelf.listPost[indexPath.row].isLike ? "\(like - 1)" : "\(like + 1)"
            strongSelf.likePost(id: strongSelf.listPost[indexPath.row].id)
        }
        
        cell.tapGoToUserInfo = {
            let userInfoVC = UserInfoVC()
            userInfoVC.userId = self.listPost[indexPath.row].userId
            self.navigationController?.pushViewController(userInfoVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailPostJobVC()
        vc.id = listPost[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extension Delegate Text Field
extension SearchRecruitmentPostVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addressTextField || textField == salaryTextField || textField == companyNameTextField || textField == descriptionTextField {
            textField.resignFirstResponder()
            searchRecruitmentPost(companyName: companyNameTextField.text, location: addressTextField.text, salary: salaryTextField.text, career: careerTextField.text, description: descriptionTextField.text)
        }
        return true
    }
}
