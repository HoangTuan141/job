//
//  PageViewVC.swift
//  jobHUMG
//
//  Created by Hoàng Tuấn on 4/5/20.
//  Copyright © 2020 TuanHA-D1. All rights reserved.
//

import UIKit

class PageViewVC: UIViewController {

    //MARK: - Outlet
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var leadingIndicatorConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageView: UIView!
    
    //MARK: - Variable
    var leftView: UIViewController?
    var rightView: UIViewController?
    var leftTitle: String?
    var rightTitle: String?
    var listVC = [UIViewController]()
    fileprivate var pageViewController: UIPageViewController!
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        leftView?.view.tag = 0
        rightView?.view.tag = 1
        listVC = [leftView ?? UIViewController(), rightView ?? UIViewController()]
        leftButton.setTitle(leftTitle, for: .normal)
        rightButton.setTitle(rightTitle, for: .normal)
        setupPageViewController()
    }
    
    //MARK: - Function
    func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.setViewControllers([listVC[0]], direction: .forward, animated: true, completion: nil)
        addChild(pageViewController)
        self.pageView.addSubview(pageViewController.view)
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.pageView.frame.width, height: self.pageView.frame.height)
        pageViewController.didMove(toParent: self)
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    func setTab(constraint: CGFloat, colorLeftButton: UIColor, colorRightButton: UIColor) {
        leadingIndicatorConstraint.constant = constraint
        leftButton.setTitleColor( colorLeftButton, for: .normal)
        rightButton.setTitleColor( colorRightButton, for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Action
    @IBAction func leftPressed(_ sender: Any) {
        pageViewController.setViewControllers([listVC[0]], direction: .reverse, animated: true, completion: nil)
        setTab(constraint: 0, colorLeftButton: .greenMainColor, colorRightButton: .grayColor)
    }
    
    @IBAction func rightPressed(_ sender: Any) {
        pageViewController.setViewControllers([listVC[1]], direction: .forward, animated: true, completion: nil)
        setTab(constraint: self.view.frame.width / 2, colorLeftButton: .grayColor, colorRightButton: .greenMainColor)
    }
}

extension PageViewVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return (viewController.view.tag > 0) ? listVC[viewController.view.tag - 1] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return (viewController.view.tag < self.listVC.count - 1) ? listVC[viewController.view.tag + 1] : nil
    }

}

extension PageViewVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let index = pageViewController.viewControllers?.first?.view.tag {
            if index == 0 {
                setTab(constraint: 0, colorLeftButton: .greenMainColor, colorRightButton: .grayColor)
            } else {
                setTab(constraint: self.view.frame.width / 2, colorLeftButton: .grayColor, colorRightButton: .greenMainColor)
            }
        }
    }
}
