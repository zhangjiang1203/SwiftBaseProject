//
//  ZJCarsDetailViewController.swift
//  SwiftBaseProject
//
//  Created by pg on 2017/8/23.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import HandyJSON


class ZJCarsDetailViewController: ZJBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var carId :String!
    
    var carModel:Result!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var carImageView: UIImageView!
    
    @IBOutlet weak var carNameLabel: UILabel!
    
    var carProprotyArr = [CarProperty]()
    
    var carDetailArr = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carImageView.setContentImageView()
        myTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            self.getCarPropertyData();
        })
        getCarPropertyData();
    }
    
    func getCarPropertyData() {
        //开始请求信息
        ZJAFRequestTool.getRequest(urlString: "http://apicloud.mob.com/car/series/query", params: ["cid":carId,"key":KShareSDKKey], success: { (response) in
            let myResponse = response as! NSDictionary
            let arr = myResponse["result"] as! NSArray
            let dict = arr.firstObject as! NSDictionary
            self.carModel = JSONDeserializer<Result>.deserializeFrom(dict: dict)
            for (key,value) in dict{
                if (value as AnyObject).isKind(of: NSArray.self) {
                    //添加到数组中
                    let property = CarProperty.init()
                    property.key = key as? String;
                    let valueArr = value as! NSArray
                    var carNameArr = [CarNameValue]()
                    for params in valueArr{
                        let carNameModel = JSONDeserializer<CarNameValue>.deserializeFrom(dict: params as? NSDictionary)
                        carNameArr.append(carNameModel!)
                    }
                    property.value = carNameArr
                    self.carProprotyArr.append(property)
                }
            }
            self.myTableView.mj_header.endRefreshing()
            self.setUpMyTabelView()
            self.myTableView.reloadData()
        }) { (errorStr) in
            print("获取信息失败==%@",errorStr)
        }
    }
    
    func setUpMyTabelView() {
        //设置图片和title
        carImageView.sd_setImage(with: URL.init(string: carModel.carImage!), placeholderImage: UIImage.init(named: ""))
        carNameLabel.text = carModel.brandName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return carProprotyArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = carProprotyArr[section]
        return (model.value?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "systemCell")
        if cell == nil{
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "systemCell")
            cell?.selectionStyle = .none
        }
        let model = carProprotyArr[indexPath.section]
        let proper = model.value?[indexPath.row]
        cell?.textLabel?.text = String(format:"%@",(proper?.name)!)
        cell?.detailTextLabel?.text = String(format:"%@",(proper?.value)!)
        
        cell?.textLabel?.textColor = RGBCOLOR_HEX(h: 0x666666)
        cell?.detailTextLabel?.textColor = RGBCOLOR_HEX(h: 0x333333)
        
        return (cell)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 40))
        headerView.backgroundColor = RGBColor(r: 220, g: 220, b: 220)
        
        let infoLabel = UILabel.init(frame: CGRect.init(x: 15, y: 10, width: 200, height: 20))
        infoLabel.textColor = RGBCOLOR_HEX(h: 0x333333);
        infoLabel.font = UIFont.systemFont(ofSize: 15);
        let model = carProprotyArr[section]
        infoLabel.text = model.key
        headerView.addSubview(infoLabel)
        return headerView;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
