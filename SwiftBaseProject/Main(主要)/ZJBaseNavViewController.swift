//
//  ZJBaseNavViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJBaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavTitleAndColorStyle()
    }
    
    func setNavTitleAndColorStyle()  {
        self.navigationBar.isTranslucent = false
        let navBar = UINavigationBar.appearance()
        navBar.tintColor = RGBCOLOR_HEX(h: 0x191919)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:RGBCOLOR_HEX(h: 0x191919),NSFontAttributeName:UIFont.systemFont(ofSize: 18)]
        //设置显示的横线
        navBar.shadowImage = UIImage()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super .pushViewController(viewController, animated: animated)
    }

}
