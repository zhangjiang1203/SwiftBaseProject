//
//  ZJForthPageView.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/29.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit


class ZJForthPageView: UIView,UITableViewDelegate,UITableViewDataSource {
    
    var headerRefresh = MJRefreshNormalHeader()
    var footerRefresh = MJRefreshBackNormalFooter()
    var refreshClouse :((_ isRefresh:Bool)->Void)!
    var parentVC = ZJForthPageViewController()
    var myTableView = UITableView()
    var showDataArr = NSArray(){
        didSet{
            //刷新数据
            myTableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpMyTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpMyTableView() {
        myTableView = UITableView.init(frame: self.bounds)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.separatorStyle = .none
        myTableView.showsHorizontalScrollIndicator = false
        myTableView.rowHeight = 100
        self.addSubview(myTableView)
        
        myTableView.register(UINib.init(nibName: "ZJForthPageCell", bundle: nil), forCellReuseIdentifier: "forthCell")
        
        headerRefresh = MJRefreshNormalHeader.init(refreshingBlock: { 
            if self.refreshClouse != nil{
                self.refreshClouse(true)
            }
        });
        footerRefresh = MJRefreshBackNormalFooter.init(refreshingBlock: {
            if self.refreshClouse != nil{
                self.refreshClouse(false)
            }
        });
        myTableView.mj_header = headerRefresh;
        myTableView.mj_footer = footerRefresh;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forthCell") as! ZJForthPageCell
        cell.selectionStyle = .none
        cell.listModel = showDataArr[indexPath.row] as! MyList
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ZJDetailContentViewController.init(nibName: nil, bundle: nil)
        let model = showDataArr[indexPath.row] as! MyList
        detailVC.pageURL = model.sourceUrl
        self.parentVC.navigationController?.pushViewController(detailVC, animated: true)
    }

}
