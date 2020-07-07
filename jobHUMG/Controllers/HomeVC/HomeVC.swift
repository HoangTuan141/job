//
//  HomeVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/3/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
   
    @IBOutlet weak var navigationView: UIView!
    @IBOutlet weak var bottomPageView: NSLayoutConstraint!
    @IBOutlet weak var tablayoutView: UIView!
    
    var tab = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveIndexOfTab), name: NSNotification.Name(rawValue: "indexOfTabPageView"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        self.setTablayout(toView: tablayoutView, leftView: RecruitmentVC(), rightView: FindJobVC(), leftTitle: "TUYỂN DỤNG", rightTitle: "TÌM VIỆC")
    }
    
    private func setupView() {
        navigationView.setGradientBackground(startColor: .greenMainColor, endColor: .rightGradientColor, gradientDirection: .leftToRight)
    }
    
    @objc func receiveIndexOfTab(_ notification: Notification) {
        if let object = notification.object {
            tab = (object as? Int)!
        }
    }
    
    @IBAction func searchPressed(_ sender: Any) {
        if tab == 0 {
            let searchVC = SearchRecruitmentPostVC()
            searchVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(searchVC, animated: true)
        } else {
            let searchVC = SearchPostFindJobVC()
            searchVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(searchVC, animated: true)
        }
    }
    
    @IBAction func postPressed(_ sender: Any) {
        self.showPopup(title: "Đăng bài", subTitle: "Chọn loại bài đăng", titleLeftButton: "Tuyển dụng", titleRightButton: "Tìm việc", onClickLeft: {
            let postJobVC = PostJobVC()
            postJobVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(postJobVC, animated: true)
        }, onClickRight:{
            let postFindJobVC = PostFindJobVC()
            postFindJobVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(postFindJobVC, animated: true)
        })
    }
    
}
