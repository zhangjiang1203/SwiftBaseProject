//
//  ZJTHirdPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJTHirdPageViewController: ZJBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    var carsArr = NSArray()
    var indexArr = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "汽车"
        self.navigationItem.leftBarButtonItems = nil
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "systemCell")
        myTableView.rowHeight = 60
        getCarTypeData()
    }
    
    //解析处理数据
    func getCarTypeData()  {
        let path = Bundle.main.path(forResource: "Car", ofType: "json");
        
        let data = NSData.init(contentsOfFile: path!)
        let pathData = try! JSONSerialization.jsonObject(with: Data.init(referencing: data!), options: .allowFragments) as! Dictionary<String, Any>
        carsArr = pathData["data"] as! NSArray
        //处理数据
        for (_,obj) in carsArr.enumerated() {
            let dict = obj as! Dictionary<String,Any>
            self.indexArr.append(dict["title"] as! String)
        }
        myTableView.reloadData()
    }
    
    ///tableView的代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        return indexArr.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 40))
        headerView.backgroundColor = RGBCOLOR_HEX(h: 0xececec)
        
        let titleLabel = UILabel.init(frame: CGRect.init(x: 20, y: 10, width: 100, height: 20))
        titleLabel.text = "\(indexArr[section])"
        titleLabel.textColor = RGBCOLOR_HEX(h: 0x666666)
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        headerView.addSubview(titleLabel);
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let carName = carsArr[section] as! Dictionary<String,Any>
        let detailCar = carName["cars"] as! Array<Dictionary<String,String>>
        return detailCar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "systemCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = RGBCOLOR_HEX(h: 0x333333)
        
        let carName = carsArr[indexPath.section] as! Dictionary<String,Any>
        let detailCar = carName["cars"] as! Array<Dictionary<String,String>>
        let carInfo = detailCar[indexPath.row] 
        cell.textLabel?.text = String(format: "%@", carInfo["name"]!)
        cell.imageView?.image = UIImage.init(named: carInfo["icon"]!)
        
        //iOS UITableViewCell 的 imageView大小更改
        let itemSize = CGSize.init(width: 40, height: 40)
        UIGraphicsBeginImageContext(itemSize);
        let imageRect = CGRect.init(x: 0, y: 0, width: 40, height: 40)
        cell.imageView?.image?.draw(in: imageRect)
        cell.imageView?.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return cell
    }
    
    //设置索引的代理方法
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexArr
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        var count = 0;
        for indexStr in indexArr {
            if indexStr.uppercased().hasPrefix(title){
                return count
            }
            count += 1;
        }
        return  0;
    }
    
    //在选择具体的型号
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carListVC = ZJCarsListViewController.init(nibName: nil, bundle: nil)
        let carName = carsArr[indexPath.section] as! Dictionary<String,Any>
        let detailCar = carName["cars"] as! Array<Dictionary<String,String>>
        let carInfo = detailCar[indexPath.row]
        carListVC.carName = String(format: "%@", carInfo["name"]!)
        self.navigationController?.pushViewController(carListVC, animated: true)
    }

}
