//
//  DetailReviewCompanyVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/15/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class DetailReviewCompanyVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable
    var id = 0
    private var listReview = [CommentReview]()
    private var detailCompany: DataDetailReviewCompany?
    private var refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDetailReviewCompany()
    }
    
    // MARK: - Method
    private func setupView() {
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 1000
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerNibCellFor(type: ReviewCompanyCell.self)
        tableView.registerNibCellFor(type: ReviewTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshDetailReviewCompany), for: .valueChanged)
        tableView.refreshControl = self.refreshControl
    }
    
    private func getDetailReviewCompany() {
        DetailReviewCompanyAPI(id: self.id).excute(target: self, success: { [weak self] response in
            guard let data = response?.data else { return }
            self?.detailCompany = data
            self?.listReview = data.ratingList
            self?.tableView.reloadData()
            self?.refreshControl.endRefreshing()
        }, error: { [weak self] error in
            self?.showAlert(title: "Lỗi", subTitle: "Đã có lỗi xảy ra. Vui lòng refresh lại để xem review công ty.", titleButton: "OK", completion: nil)
            self?.refreshControl.endRefreshing()
        })
    }
    
    private func likeReview(id: Int) {
        LikeReviewAPI(id: id).excute(target: self, success: { [weak self] response in
            self?.getDetailReviewCompany()
        }, error: { error in
        })
    }
    
    private func disLikeReview(id: Int) {
        DislikeReviewAPI(id: id).excute(target: self, success: { [weak self] response in
            self?.getDetailReviewCompany()
        }, error: { error in
        })
    }
    
    @objc func refreshDetailReviewCompany() {
        self.getDetailReviewCompany()
    }
    
    // MARK: - Action
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createReviewPressed(_ sender: Any) {
        let createVC = CreateReviewCompanyVC()
        createVC.hidesBottomBarWhenPushed = true
        createVC.id = self.detailCompany?.id ?? 0
        self.navigationController?.pushViewController(createVC, animated: true)
    }
}

// MARK: - TableView
extension DetailReviewCompanyVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return listReview.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCompanyCell", for: indexPath) as! ReviewCompanyCell
            cell.selectionStyle = .none
            if let data = self.detailCompany {
                cell.fillData(data: data)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
            cell.selectionStyle = .none
            cell.fillData(data: listReview[indexPath.row])
            
            cell.onTapLikeButton = {
                cell.likeLabel.text = "\(self.listReview[indexPath.row].likeCount + 1)"
                self.likeReview(id: self.listReview[indexPath.row].id)
            }
            
            cell.onTapDisLikeButton = {
                cell.dislikeLabel.text = "\(self.listReview[indexPath.row].disLikeCount + 1)"
                self.disLikeReview(id: self.listReview[indexPath.row].id)
            }
            
            return cell
        }
    }
    
}
