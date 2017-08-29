//
//  ZJForthModel.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/29.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import HandyJSON

class ZJForthModel: HandyJSON {
    
    var msg: String?
    
    var result: MyResult?
    
    var retCode: String?
    
    required init() {
        
    }
    
}

class MyResult: HandyJSON {
    
    var curPage: Int = 0
    
    var total: Int = 0
    
    var list: [MyList]?
    
    required init() {
        
    }
    
}

class MyList: HandyJSON {
    
    var thumbnails: String?
    
    var ID: String?
    
    var sourceUrl: String?
    
    var title: String?
    
    var hitCount: String?
    
    var pubTime: String?
    
    var subTitle: String?
    
    var cid: String?
    
    required init() {
        
    }
    
    
}

