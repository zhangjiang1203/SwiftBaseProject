//
//  ZJBookSearchViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/9/26.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import Then
import HandyJSON
import RxSwift
import RxCocoa


class ZJBookSearchViewController: ZJBaseViewController ,UITextFieldDelegate{
    
    var searchTextView:UITextField!
    var searchBtn:UIButton!
    var backImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加背景图片
        backImageView = UIImageView.init(frame: self.view.bounds)
        backImageView.image = UIImage(named: "locationBGImage")
        self.view.addSubview(backImageView)
        //添加模糊处理 
        let effect = UIBlurEffect(style:.light)
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = self.view.bounds
        backImageView.addSubview(effectView)
        
        searchTextView = UITextField.init()
        searchTextView.frame = CGRect.init(x: 20, y: 50, width: KScreenWidth-40, height: 40)
        searchTextView.textColor = RGBCOLOR_HEX(h: 0x333333)
        searchTextView.placeholder = "请输入图书名进行查询"
        
        searchBtn = UIButton.init(frame: CGRect.init(x: 20, y: 120, width: KScreenWidth-40, height: 40))
        searchBtn.titleLabel?.font = .systemFont(ofSize: 17)
        searchBtn.setTitle("搜索", for: .normal)
        searchBtn.rx.tap
            .subscribe(onNext: {
                //开始搜索
                self.startSearchBooks()
            })
            .addDisposableTo(DisposeBag())
        
        self.view.addSubview(searchTextView)
        self.view.addSubview(searchBtn);
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
    
    func startSearchBooks() {
        ZJAFRequestTool.getRequest(urlString: "https://api.douban.com/v2/book/search", params: ["q":searchTextView.text!], success: { (response) in
            if let model = JSONDeserializer<ZJBookModel>.deserializeFrom(dict: response as? NSDictionary){
                let bookVC = ZJBookListViewController.init(nibName: nil, bundle: nil)
                bookVC.searchDataArr = model.books!
                bookVC.searchStr = self.searchTextView.text
                self.navigationController?.pushViewController(bookVC, animated: true)
            }
        }) { (errorStr) in
            print("返回的错误信息===%@",errorStr)
        }
    }
}
