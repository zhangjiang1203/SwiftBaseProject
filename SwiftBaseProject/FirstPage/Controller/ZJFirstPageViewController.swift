//
//  ZJFirstPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result



class ZJFirstPageViewController: ZJBaseViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var viewManager:ZJFirstPageManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        addMySegmentInit()
        
    }
    
    func addMySegmentInit()  {
        
        viewManager = ZJFirstPageManager.init()
        viewManager.showTableView = myTableView
        
        myTableView.register(UINib.init(nibName: "ZJFirstPageCell", bundle: nil), forCellReuseIdentifier: "ZJFirstPageCell")
        myTableView.delegate = viewManager
        myTableView.dataSource = viewManager
        
        //设置刷新
        var images:Array<UIImage> = []
        for i in 1...4 {
            images.append(UIImage.init(named: "bdj_mj_refresh_\(i)")!)
        }
        let gifHeader = MJRefreshGifHeader()
        gifHeader.setImages(images, for: .idle)
        gifHeader.setImages(images, for: .pulling)
        gifHeader.setImages(images, for: .refreshing)
        
        gifHeader.setRefreshingTarget(self, refreshingAction: #selector(beginRefresh))
        
        myTableView.mj_header = gifHeader

        myTableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.myTableView.mj_footer.endRefreshing()
        })
        
        //设置分段器
        let segmentView = ZJSegmentScrollView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 40))
        segmentView.selectedColor = RGBCOLOR_HEX(h: 0x00c866)
        segmentView.scrollClouse = {(index) in
            var infoType = 0
            switch index {
            case 0:
                infoType = 10
            case 1:
                infoType = 29
            case 2:
                infoType = 31
            case 3:
                infoType = 41
            default:
                break;
            }
            MBProgressHUD.showAdded(to: self.view, animated: true)
            self.viewManager.infoType = infoType
            
        }
        segmentView.segmentTitleArr = ["图片","段子","声音","视频"]
        self.view.addSubview(segmentView)
    }
    
    /// 开始刷新
    func beginRefresh() {
        myTableView.mj_header.endRefreshing()
    }
    
}
