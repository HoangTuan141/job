//
//  SearchPostFindJobVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 7/2/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class SearchPostFindJobVC: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var careerTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    
    // MARK: - Variable
    private var listPostFindJob = [DataListPostFindJob]()
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
        descriptionTextField.delegate = self
        addressTextField.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.registerNibCellFor(type: FindJobTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func searchPostFindJob(location: String?, career: String?, description: String?) {
        SearchPostFindJobAPI(location: location, career: career, description: description).excute(target: self, success: { [weak self] response in
            guard let data = response?.data else { return }
            self?.listPostFindJob = data
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }, error: { error in
            self.refreshControl.endRefreshing()
        })
    }
    
    private func likePost(id: Int) {
        LikePostAPI(id: id).excute(target: self, success: { [weak self] response in
            self?.searchPostFindJob(location: self?.addressTextField.text, career: self?.careerTextField.text, description: self?.descriptionTextField.text)
        }, error: { error in
        })
    }
    
    @objc func refreshList() {
        searchPostFindJob(location: addressTextField.text, career: careerTextField.text, description: descriptionTextField.text)
    }
    
    // MARK: - Action
    @IBAction func careerPressed(_ sender: Any) {
        self.dismissKeyboard()
        self.showListCareerPopup(career: careerTextField.text!, completion: { [weak self] career in
            self?.careerTextField.text = career
            self?.searchPostFindJob(location: self?.addressTextField.text, career: self?.careerTextField.text, description: self?.descriptionTextField.text)
        })
    }
    
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchPostFindJobVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPostFindJob.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindJobTableViewCell", for: indexPath) as! FindJobTableViewCell
        cell.selectionStyle = .none
        cell.fillData(data: listPostFindJob[indexPath.row])
        
        cell.tapCommentButton = { [weak self] in
            let detailVC = DetailPostFindJobVC()
            detailVC.id = self?.listPostFindJob[indexPath.row].id
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }
        
        cell.tapLikeButton = { [weak self] in
            guard let strongSelf = self else { return }
            cell.setupLikeButton(isLike: !strongSelf.listPostFindJob[indexPath.row].isLike)
            let like = strongSelf.listPostFindJob[indexPath.row].likeCount
            cell.likeLabel.text = strongSelf.listPostFindJob[indexPath.row].isLike ? "\(like - 1)" : "\(like + 1)"
            strongSelf.likePost(id: strongSelf.listPostFindJob[indexPath.row].id)
        }
        
        cell.tapGoToUserInfo = {
            let userInfoVC = UserInfoVC()
            userInfoVC.userId = self.listPostFindJob[indexPath.row].userId
            self.navigationController?.pushViewController(userInfoVC, animated: true)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailPostFindJobVC()
        detailVC.id = listPostFindJob[indexPath.row].id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SearchPostFindJobVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == addressTextField || textField == careerTextField || textField == descriptionTextField {
            searchPostFindJob(location: addressTextField.text, career: careerTextField.text, description: descriptionTextField.text)
            textField.resignFirstResponder()
        }
        return true
    }
}
