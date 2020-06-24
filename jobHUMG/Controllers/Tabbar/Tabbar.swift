//
//  Tabbar.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/3/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        let homeVC = HomeVC()
        let reviewCompanyVC = ReviewCompanyVC()
        let profileVC = ProfileVC()
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: reviewCompanyVC)
        let nav3 = UINavigationController(rootViewController: profileVC)
        
        nav1.isNavigationBarHidden = true
        nav2.isNavigationBarHidden = true
        nav3.isNavigationBarHidden = true
        
        nav1.tabBarItem = UITabBarItem(title: "Trang chủ", image: #imageLiteral(resourceName: "ic_home"), tag: 0)
        nav2.tabBarItem = UITabBarItem(title: "Review Công ty", image: #imageLiteral(resourceName: "ic_review"), tag: 1)
        nav3.tabBarItem = UITabBarItem(title: "Cá nhân", image: #imageLiteral(resourceName: "ic_profile"), tag: 2)
        
        self.viewControllers = [nav1, nav2, nav3]
        self.tabBar.tintColor = #colorLiteral(red: 0.2588235294, green: 0.6352941176, blue: 0.1882352941, alpha: 1)
        self.tabBar.isTranslucent = false
        self.tabBar.backgroundColor = .white
    }
}
