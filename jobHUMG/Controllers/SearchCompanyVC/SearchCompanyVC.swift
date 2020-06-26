//
//  SearchCompanyVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/15/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class SearchCompanyVC: UIViewController {

    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    var listCompany = [DataSearchCompany]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
        setupTableView()
    }
    
    private func setupTextField() {
        companyNameTextField.becomeFirstResponder()
        companyNameTextField.addTarget(self, action: #selector(search), for: .editingChanged)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerNibCellFor(type: SearchCompanyTableCell.self)
    }
    
    @objc func search() {
        if companyNameTextField.text!.count >= 1 {
            searchCompany(name: companyNameTextField.text!)
        } else {
            self.listCompany.removeAll()
            self.tableView.reloadData()
        }
    }
    
    private func searchCompany(name: String) {
        SearchCompanyAPI(name: name).excute(target: self, success: { [weak self] response in
            guard let data = response?.data else { return }
            self?.listCompany = data
            self?.tableView.reloadData()
        }, error: { error in
            self.listCompany.removeAll()
            self.tableView.reloadData()
        })
    }

    @IBAction func backPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchCompanyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCompany.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCompanyTableCell", for: indexPath) as! SearchCompanyTableCell
        cell.setupCell(data: listCompany[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailReviewVC = DetailReviewCompanyVC()
        detailReviewVC.id = listCompany[indexPath.row].id
        self.navigationController?.pushViewController(detailReviewVC, animated: true)
    }
    
}
