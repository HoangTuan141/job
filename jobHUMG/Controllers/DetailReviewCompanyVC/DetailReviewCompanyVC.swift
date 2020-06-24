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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
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
    }
    
    // MARK: - Action
    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createReviewPressed(_ sender: Any) {
        let createVC = CreateReviewCompanyVC()
        createVC.hidesBottomBarWhenPushed = true
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
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCompanyCell", for: indexPath) as! ReviewCompanyCell
            cell.selectionStyle = .none
//            cell.fillDataTest(avatar: reviewAvatar[indexPath.row], name: reviewName[indexPath.row], rate: Double(reviewStar[indexPath.row]))
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

// MARK: - Delegate cell
extension DetailReviewCompanyVC: ReviewTableCellDelegate {
    func onClickLike() {
    }
    
    func onClickDislike() {
    }
    
}
