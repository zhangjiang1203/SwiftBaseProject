//
//  ZJFirstPageManager.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/7.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON


class ZJFirstPageManager: NSObject,UITableViewDelegate,UITableViewDataSource {

    //添加的视图
    var showTableView :UITableView!
    var emptyDataArr = NSArray()
    
    //刷新的page
    var page:NSInteger = 1
    
    //开始设置数据
    var segmentTitleArr = NSMutableArray()
    
    var infoType:NSInteger = 0{
        didSet{
            addAlamofireNetTest(isRefresh: true)
        }
    }
    
    //开始加载数据
    override init() {
        super.init()
    }
    
    //   type   type=10 图片 type=29 段子 type=31 声音 type=41 视频
    //   page
    func addAlamofireNetTest(isRefresh:Bool)   {
        
        if isRefresh {
            page = 1
            self.segmentTitleArr = NSMutableArray()
        }else{
            page += 1
        }
        
        ZJAFRequestTool.getRequest(urlString: "http://api.budejie.com/api/api_open.php?a=list&c=data", params: ["type":infoType,"page":page], success: { (result) in
            self.showTableView.mj_header.endRefreshing()
            self.showTableView.mj_footer.endRefreshing()
            if let model = JSONDeserializer<ZJRequestTestModel>.deserializeFrom(dict: result as? NSDictionary){
                MBProgressHUD.hide(for: self.showTableView.superview!, animated: true)
                self.segmentTitleArr.addObjects(from:model.list!)
                self.showTableView.reloadData()
            }
        }) { (errorStr) in
            self.showTableView.mj_header.endRefreshing()
            self.showTableView.mj_footer.endRefreshing()
            print("错误信息===\(errorStr)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentTitleArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJFirstPageCell", for: indexPath) as! ZJFirstPageCell
        cell.selectionStyle = .none
        cell.listData = segmentTitleArr[indexPath.row] as! List
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (segmentTitleArr[indexPath.row] as! List).cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
