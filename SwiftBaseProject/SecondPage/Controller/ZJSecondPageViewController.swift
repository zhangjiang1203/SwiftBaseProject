//
//  ZJSecondPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import HandyJSON

class ZJSecondPageViewController: ZJBaseViewController,UITextFieldDelegate {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userNameField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameField.delegate = self
        self.userNameField.tintColor = RGBCOLOR_HEX(h: 0xececec)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        ZJAFRequestTool.getRequest(urlString: "https://api.douban.com/v2/book/search", params: ["q":textField.text!], success: { (response) in
            print("返回的信息===%@",response)
            if let model = JSONDeserializer<ZJBookModel>.deserializeFrom(dict: response as? NSDictionary){
                let bookVC = ZJBookListViewController.init(nibName: nil, bundle: nil)
                bookVC.searchDataArr = model.books as! NSMutableArray
                self.navigationController?.pushViewController(bookVC, animated: true)
            }

        }) { (errorStr) in
            print("返回的错误信息===%@",errorStr)
        }
        return true
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}


extension UIColor {
    //返回随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}

