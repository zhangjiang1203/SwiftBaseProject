//
//  ZJDetailContentViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/29.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import WebKit

class ZJDetailContentViewController: ZJBaseViewController,WKUIDelegate {

    var pageURL:String?
    
    var myWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !(pageURL?.contains("http://"))! {
            pageURL = "http://www.baidu.com"
        }
        
        myWebView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: KScreenHight-64))
        myWebView.uiDelegate = self
        myWebView.load(URLRequest.init(url: URL.init(string: pageURL!)!))
        self.view.addSubview(myWebView)
        
    }
    
    

}
