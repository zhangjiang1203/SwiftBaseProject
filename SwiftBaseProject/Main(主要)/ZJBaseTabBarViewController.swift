//
//  ZJBaseTabBarViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJBaseTabBarViewController: UITabBarController,ZJTabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        initMyShowViewController()
        addTabBarView()
    }
    
    //初始化视图
    func initMyShowViewController()  {
        let firstPage = ZJFirstPageViewController.init(nibName: "ZJFirstPageViewController", bundle: nil)
        let secondPage = ZJSecondPageViewController.init(nibName: "ZJSecondPageViewController", bundle: nil)
        let thirdPage = ZJTHirdPageViewController.init(nibName: "ZJTHirdPageViewController", bundle: nil)
        let forthPage = ZJForthPageViewController.init(nibName: "ZJForthPageViewController", bundle: nil)
        let vcs = [firstPage,secondPage,thirdPage,forthPage]
        let navs = NSMutableArray.init();
        for viewControllers in vcs{
            let nav = ZJBaseNavViewController.init(rootViewController: viewControllers);
            navs.add(nav)
        }
        self.viewControllers = navs as? [UIViewController];
    }
    
    //添加tabbarView
    func addTabBarView() {
        let tabbar = ZJTabBarView.init(frame: self.tabBar.bounds)
        tabbar.delegate = self
        tabbar.clickAction = {(index) in
            self.selectedIndex = index
        }
        self.tabBar.addSubview(tabbar)
    }
    
    //切换视图
    func buttonIndexClick(index: NSInteger) {
        self.selectedIndex = index
    }
}
