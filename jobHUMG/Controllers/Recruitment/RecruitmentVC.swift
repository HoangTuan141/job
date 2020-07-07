//
//  RecruitmentVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/5/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class RecruitmentVC: UIViewController {

    // MARK: - OUTLET
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable
    private var listPost = [DataListRecruitmentPost]()
    private var refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListRecruitmentPost()
    }
    
    // MARK: Method
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.registerNibCellFor(type: RecruitmentCell.self)
        refreshControl.addTarget(self, action: #selector(refreshListPost), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
    }
    
    private func getListRecruitmentPost() {
        ListRecruitmentPostAPI().excute(target: self, success: { [weak self] response in
            self?.listPost = response!.data
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        },error: {[weak self] error in
            self?.refreshControl.endRefreshing()
            })
    }
    
    private func likePost(id: Int) {
        LikePostAPI(id: id).excute(target: self, success: { [weak self] response in
            self?.getListRecruitmentPost()
        }, error: { error in
        })
    }
    
    @objc func refreshListPost() {
        self.getListRecruitmentPost()
    }
}

extension RecruitmentVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPost.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecruitmentCell", for: indexPath) as! RecruitmentCell
        cell.selectionStyle = .none
        cell.fillData(data: listPost[indexPath.row])
        
        cell.tapGoToUserInfo = {
            let userInfoVC = UserInfoVC()
            userInfoVC.userId = self.listPost[indexPath.row].userId
            self.navigationController?.pushViewController(userInfoVC, animated: true)
        }
        
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
