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
        self.navigationItem.leftBarButtonItems = nil
        userNameField.delegate = self
        self.userNameField.tintColor = RGBCOLOR_HEX(h: 0xececec)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        ZJAFRequestTool.getRequest(urlString: "https://api.douban.com/v2/book/search", params: ["q":textField.text!], success: { (response) in
            if let model = JSONDeserializer<ZJBookModel>.deserializeFrom(dict: response as? NSDictionary){
                let bookVC = ZJBookListViewController.init(nibName: nil, bundle: nil)
                bookVC.searchDataArr = model.books!
                bookVC.searchStr = textField.text
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


