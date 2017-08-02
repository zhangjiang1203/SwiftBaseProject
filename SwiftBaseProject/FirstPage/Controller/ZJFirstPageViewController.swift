//
//  ZJFirstPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import Alamofire


class ZJFirstPageViewController: ZJBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        addAlamofireNetTest()
    }

    func addAlamofireNetTest()   {
        
        ZJAFRequestTool.getRequest(urlString: "http://api.budejie.com/api/api_open.php?a=list&c=data&type=29", params: ["":""], success: { (result) in
            print("获取到的数据%@",result["list"])
        }) { (errorStr) in
            print("错误信息===\(errorStr)")
        }
        
    }
}
