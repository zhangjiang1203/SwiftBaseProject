//
//  ZJCarsListViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/23.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJCarsListViewController: ZJBaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var carDetailArr = [Dictionary<String, Any>]()
    
    var carName:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "systemCell")
        ZJAFRequestTool.getRequest(urlString: "http://apicloud.mob.com/car/brand/query?key=10318870f4a99", params: ["key":"10318870f4a99"], success: { (response) in
            let dict = response as! Dictionary<String, Any>
            let allCars = dict["result"] as! Array<Dictionary<String, Any>>
            for (_,value) in allCars.enumerated(){
                
                let carName = value["name"] as! String
                if (carName.contains(self.carName)){
                    self.carDetailArr = value["son"] as! [Dictionary<String, Any>]
                    print("%@",self.carDetailArr)
                    break
                }
            }
        }) { (errorStr) in
            print("请求出错===%@",errorStr)
        }
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "systemCell", for: indexPath)
        return cell
        
    }
   

}
