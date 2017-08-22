//
//  ZJBookListViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/22.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import HandyJSON


class ZJBookListViewController: ZJBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var myTableView :UITableView!
    var searchStr:String!
    var searchDataArr = NSMutableArray()
    var startPage = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = true
        myTableView = UITableView.init(frame: self.view.bounds, style: .plain)
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.showsVerticalScrollIndicator = false
        myTableView.showsHorizontalScrollIndicator = false
        myTableView.rowHeight = 100
        myTableView.register(UINib.init(nibName: "ZJShowBookCell", bundle: nil), forCellReuseIdentifier: "bookCell")
        myTableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: { 
            self.searchMyContentBook(isRefresh: true)
        });
        myTableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            self.searchMyContentBook(isRefresh: false)
        });
        self.view.addSubview(myTableView)
    }
    
    func searchMyContentBook(isRefresh:Bool)  {
        
        if isRefresh{
            startPage = 0
            searchDataArr = NSMutableArray()
        }else{
            startPage = startPage+20
        }
        
        ZJAFRequestTool.getRequest(urlString: "https://api.douban.com/v2/book/search", params: ["q":searchStr,"start":startPage], success: { (response) in
            print("返回的信息===%@",response)
            if let model = JSONDeserializer<ZJBookModel>.deserializeFrom(dict: response as? NSDictionary){
                self.searchDataArr.addObjects(from: model.books!);
                self.myTableView.reloadData()
                self.myTableView.mj_footer.endRefreshing()
                self.myTableView.mj_header.endRefreshing()
            }
        }) { (errorStr) in
            self.myTableView.mj_footer.endRefreshing()
            self.myTableView.mj_header.endRefreshing()
            print("返回的错误信息===%@",errorStr)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! ZJShowBookCell
        cell.bookModel = searchDataArr[indexPath.row] as! Books
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ZJBookDetailViewController.init(nibName: "ZJBookDetailViewController", bundle: nil)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    

}
