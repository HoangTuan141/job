//
//  ReviewCompanyVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/3/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class ReviewCompanyVC: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variable
    var listCompany = [DataListCompany] ()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        getListCompany()
    }
    
    // MARK: - Method
    private func setupView() {
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.registerNibCellFor(type: ReviewCompanyCell.self)
    }
    
    private func getListCompany() {
        ListCompanyReviewAPI().excute(target: self, success: { [weak self] response in
            self?.listCompany = response!.data
            self?.tableView.reloadData()
        }, error: { [weak self] response in
            self?.showAlert(title: "Lỗi", subTitle: "Đã có lỗi xảy ra, vui lòng refresh lại trang.", titleButton: "OK", completion: nil)
        })
    }
    
    // MARK: - Action
    @IBAction func searchPressed(_ sender: Any) {
        let searchCompanyVC = SearchCompanyVC()
        self.navigationController?.pushViewController(searchCompanyVC, animated: true)
    }
    
    @IBAction func suggestCompanyPressed(_ sender: Any) {
        let suggestPopup = SuggestCompanyPopupVC()
        suggestPopup.modalPresentationStyle = .overCurrentContext
        suggestPopup.suggestCompanySuccess = {
            self.getListCompany()
        }
        
        suggestPopup.suggestCompanyFailed = {
            self.showAlert(title: "Không tạo được gợi ý công ty", subTitle: "Đã có lỗi xảy ra. Vui lòng thử lại", titleButton: "OK", completion: nil)
        }
        self.present(suggestPopup, animated: false, completion: nil)
    }
    
}

extension ReviewCompanyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCompany.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCompanyCell", for: indexPath) as! ReviewCompanyCell
        cell.selectionStyle = .none
        cell.setupCell(data: listCompany[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailReviewCompanyVC()
        detailVC.hidesBottomBarWhenPushed = true
        detailVC.id = listCompany[indexPath.row].id ?? 0
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
