//
//  ZJDetailContentViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/29.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import WebKit

class ZJDetailContentViewController: ZJBaseViewController,WKNavigationDelegate {

    var pageURL:String?
    
    var myWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if !(pageURL?.contains("http://"))! {
            pageURL = "http://www.baidu.com"
        }
        
        let size = UIScreen.main.bounds.size
        if size.equalTo(CGSize.init(width:2436, height:  2436)) {
            myWebView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: KScreenHight-64-34))
        }else{
            myWebView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: KScreenHight-64))
        }
        
        myWebView.navigationDelegate = self
        myWebView.load(URLRequest.init(url: URL.init(string: pageURL!)!))
        self.view.addSubview(myWebView)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        NSLog("开始加载")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        NSLog("加载失败")
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        NSLog("加载完成")
        MBProgressHUD.hide(for: self.view, animated: true)
        self.title = webView.title
    }
    

    

}
