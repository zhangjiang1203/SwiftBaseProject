//
//  ZJCarsListViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/23.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJCarsListViewController: ZJBaseViewController,UITableViewDelegate,UITableViewDataSource {

    fileprivate var leftTableView: UITableView!
    
    fileprivate var rightTableView: UITableView!
    
    var lineLabel = UILabel()
    
    var carsDataList = Dictionary<String,Any>()
    var leftDetailArr = [Dictionary<String, Any>]()
    var rightDetailArr = [Dictionary<String,String>]()

    var carName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "筛选列表"
        initMyTableView()
    }

    
    func initMyTableView()  {
        
        leftTableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: KScreenHight-64), style: .plain)
        leftTableView.delegate = self
        leftTableView.dataSource = self
        leftTableView.tag = 1
        leftTableView.isHidden = true
        leftTableView.showsVerticalScrollIndicator = false
        leftTableView.showsHorizontalScrollIndicator = false
        leftTableView.register(UITableViewCell.self, forCellReuseIdentifier: "leftCell")
        self.view.addSubview(leftTableView)
        
        rightTableView = UITableView.init(frame: CGRect.zero, style: .plain)
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.tag = 2
        rightTableView.showsVerticalScrollIndicator = false
        rightTableView.showsHorizontalScrollIndicator = false
        rightTableView.register(UITableViewCell.self, forCellReuseIdentifier: "rightCell")
        self.view.addSubview(rightTableView)
        
        lineLabel = UILabel.init(frame: CGRect.init(x: KScreenWidth, y: 0, width: 1, height: KScreenHight-64))
        lineLabel.backgroundColor = RGBCOLOR_HEX(h: 0xececec)
        self.view.addSubview(lineLabel)
        
        //获取品牌数据
        ZJAFRequestTool.getRequest(urlString: "http://apicloud.mob.com/car/brand/query", params: ["key":KShareSDKKey], success: { (response) in
            self.carsDataList = response as! Dictionary<String, Any>
            let allCars = self.carsDataList["result"] as! Array<Dictionary<String, Any>>
            for (_,value) in allCars.enumerated(){
                let carName = value["name"] as! String
                if (carName.contains(self.carName)){
                    self.leftDetailArr = value["son"] as! [Dictionary<String, Any>]
                    break
                }
            }
            self.leftTableView.isHidden = false
            self.leftTableView.reloadData()
        }) { (errorStr) in
            print("请求出错===%@",errorStr)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
            return leftDetailArr.count
        }else{
            return rightDetailArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "leftCell", for: indexPath)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel?.textColor = RGBCOLOR_HEX(h: 0x333333)
            let dict = leftDetailArr[indexPath.row]
            cell.textLabel?.text = dict["type"] as? String
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "rightCell", for: indexPath)
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
            cell.textLabel?.textColor = RGBCOLOR_HEX(h: 0x333333)
            let dict = rightDetailArr[indexPath.row] 
            cell.textLabel?.text = dict["seriesName"]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //查看详情
        if tableView.tag == 1 {
            leftTableView.mj_w = KScreenWidth/4
            lineLabel.mj_x = KScreenWidth/4
            rightTableView.frame = CGRect.init(x: KScreenWidth/4, y: 0, width: KScreenWidth*3/4, height: KScreenHight-64)
            //查询数据
            let dict = leftDetailArr[indexPath.row]
            ZJAFRequestTool.getRequest(urlString: "http://apicloud.mob.com/car/seriesname/query", params: ["name":dict["type"]!,"key":KShareSDKKey], success: { (response) in
                self.rightDetailArr = response["result"] as! Array<Dictionary<String,String>>
                self.rightTableView.reloadData()
            }, failture: { (errorStr) in
                print("请求失败===%@",errorStr)
            })
        }else{
            let detailVC = ZJCarsDetailViewController.init(nibName:"ZJCarsDetailViewController", bundle: nil)
            detailVC.title = rightDetailArr[indexPath.row]["brandName"]
            detailVC.carId = rightDetailArr[indexPath.row]["carId"]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
