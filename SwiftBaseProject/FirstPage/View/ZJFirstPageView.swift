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
    
    var gifHeader = MJRefreshGifHeader()
    var footerRefresh = MJRefreshBackNormalFooter()
    var refreshClouse :((_ isRefresh:Bool)->Void)!
    var parentVC = ZJFirstPageViewController()
    

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
    fileprivate func setupMyUIData()  {
        myTableView = UITableView.init(frame: self.bounds)
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.separatorStyle = .none
        myTableView.register(UINib.init(nibName: "ZJFirstPageCell", bundle: nil), forCellReuseIdentifier: "ZJFirstPageCell")
        
        //设置头部和底部刷新
        var images:Array<UIImage> = []
        for i in 1...4 {
            images.append(UIImage.init(named: "bdj_mj_refresh_\(i)")!)
        }
        gifHeader = MJRefreshGifHeader()
        gifHeader.setImages(images, for: .idle)
        gifHeader.setImages(images, for: .pulling)
        gifHeader.setImages(images, for: .refreshing)
        gifHeader.setRefreshingTarget(self, refreshingAction: #selector(beginRefresh))
        myTableView.mj_header = gifHeader

        footerRefresh = MJRefreshBackNormalFooter(refreshingBlock: {
            if self.refreshClouse != nil{
                self.refreshClouse(false)
            }
        })
        myTableView.mj_footer = footerRefresh
        self.addSubview(myTableView)
    }
    
    @objc fileprivate func beginRefresh()  {
        if self.refreshClouse != nil{
            self.refreshClouse(true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageDataArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZJFirstPageCell", for: indexPath) as! ZJFirstPageCell
        cell.selectionStyle = .none
        let list = pageDataArr[indexPath.row] as! List
        list.dataIndex = indexPath.row
        cell.listData = list
        cell.refreshClouser = {
            model in
            self.pageDataArr.replaceObject(at: model.dataIndex, with: model)
            if self.pageDataArr.count > 0 {
                self.myTableView.reloadRows(at: [IndexPath.init(row: model.dataIndex, section: 0)], with: .fade)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (pageDataArr[indexPath.row] as! List).cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentVC = ZJDetailContentViewController.init(nibName: nil, bundle: nil)
        let model = pageDataArr[indexPath.row] as! List
        contentVC.pageURL = model.weixin_url
        self.parentVC.navigationController?.pushViewController(contentVC, animated: true)
        
    }
    
}
