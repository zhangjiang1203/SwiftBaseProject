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
    //开始设置数据
    var segmentTitleArr:Array<List> = []{
        didSet{
           showTableView.reloadData()
           showTableView.scrollToRow(at: NSIndexPath.init(row: 0, section: 0) as IndexPath, at: .top, animated: false)
        }
    }
    
    var infoType:NSInteger = 0{
        didSet{
            addAlamofireNetTest()
        }
    }
    
    //开始加载数据
    override init() {
        super.init()
    }
    
    //   type   type=10 图片 type=29 段子 type=31 声音 type=41 视频
    //   page
    func addAlamofireNetTest()   {
        ZJAFRequestTool.getRequest(urlString: "http://api.budejie.com/api/api_open.php?a=list&c=data", params: ["type":infoType], success: { (result) in
            if let model = JSONDeserializer<ZJRequestTestModel>.deserializeFrom(dict: result as? NSDictionary){
                MBProgressHUD.hide(for: self.showTableView.superview!, animated: true)
                self.segmentTitleArr = model.list!
                
            }
        }) { (errorStr) in
            print("错误信息===\(errorStr)")
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentTitleArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJFirstPageCell", for: indexPath) as! ZJFirstPageCell
        cell.selectionStyle = .none
        cell.listData = segmentTitleArr[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return segmentTitleArr[indexPath.row].cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}
