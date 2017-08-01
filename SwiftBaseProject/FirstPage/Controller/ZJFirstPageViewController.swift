//
//  ZJFirstPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import Moya

class ZJFirstPageViewController: ZJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "首页"
        
        //初始化网络请求
        let provider = MoyaProvider<RequestModel>.init()
        
    }
    

}
