//
//  ZJSecondPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ZJSecondPageViewController: ZJBaseViewController,UITextFieldDelegate {

    var myTableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItems = nil
        self.title = "新闻"
    }
    
    
    
}


