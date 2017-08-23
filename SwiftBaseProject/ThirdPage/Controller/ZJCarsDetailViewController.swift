//
//  ZJCarsDetailViewController.swift
//  SwiftBaseProject
//
//  Created by pg on 2017/8/23.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJCarsDetailViewController: ZJBaseViewController {

    var carId :String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //开始请求信息
        ZJAFRequestTool.getRequest(urlString: "http://apicloud.mob.com/car/series/query", params: ["cid":carId,"key":"10318870f4a99"], success: { (response) in
            print("获取车的具体信息===%@",response)
        }) { (errorStr) in
            print("获取信息失败==%@",errorStr)
        }
        
        
    }

}
