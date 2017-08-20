//
//  ZJFirstPageView.swift
//  SwiftBaseProject
//
//  Created by pg on 2017/8/17.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJFirstPageView: UIView,UITableViewDelegate,UITableViewDataSource {

    fileprivate var myTableView:UITableView!
    
    var headerRefresh = MJRefreshNormalHeader()
    var footerRefresh = MJRefreshBackNormalFooter()
    
    
    var pageDataArr = NSMutableArray(){
        didSet{
            myTableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMyUIData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //初始化控件
    func setupMyUIData()  {
        myTableView = UITableView.init(frame: self.bounds)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        myTableView.register(UINib.init(nibName: "ZJFirstPageCell", bundle: nil), forCellReuseIdentifier: "ZJFirstPageCell")
        headerRefresh = MJRefreshNormalHeader(refreshingBlock: {
            self.myTableView.mj_header.endRefreshing()
        })
        myTableView.mj_header = headerRefresh
        footerRefresh = MJRefreshBackNormalFooter(refreshingBlock: { 
            self.myTableView.mj_footer.endRefreshing()
        })
        myTableView.mj_footer = footerRefresh
        self.addSubview(myTableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageDataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJFirstPageCell", for: indexPath) as! ZJFirstPageCell
        cell.selectionStyle = .none
        cell.listData = pageDataArr[indexPath.row] as! List
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (pageDataArr[indexPath.row] as! List).cellHeight
    }
    
}
