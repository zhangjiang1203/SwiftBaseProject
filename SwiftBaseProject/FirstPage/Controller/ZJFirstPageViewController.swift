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

class ZJFirstPageViewController: ZJBaseViewController,iCarouselDelegate,iCarouselDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
//    var viewManager:ZJFirstPageManager!
    
    var icarouselView = iCarousel()
    
    var viewManager = ZJCarouselManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        addIcarouselView()
        
    }
    
    func addMySegmentInit()  {
        
//        viewManager = ZJFirstPageManager.init()
//        viewManager.showTableView = myTableView
//        
//        myTableView.register(UINib.init(nibName: "ZJFirstPageCell", bundle: nil), forCellReuseIdentifier: "ZJFirstPageCell")
//        myTableView.delegate = viewManager
//        myTableView.dataSource = viewManager
        
        //设置头部和底部刷新
//        var images:Array<UIImage> = []
//        for i in 1...4 {
//            images.append(UIImage.init(named: "bdj_mj_refresh_\(i)")!)
//        }
//        let gifHeader = MJRefreshGifHeader()
//        gifHeader.setImages(images, for: .idle)
//        gifHeader.setImages(images, for: .pulling)
//        gifHeader.setImages(images, for: .refreshing)
//        gifHeader.setRefreshingTarget(self, refreshingAction: #selector(beginRefresh))
//        myTableView.mj_header = gifHeader
//
//        myTableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
//            self.viewManager.addAlamofireNetTest(isRefresh: false)
//        })
    }
    
    func addIcarouselView()  {
        
        viewManager = ZJCarouselManager.init()
        viewManager.refreshInformation(index: 0, type: 10) { (dataArr) in
            print("获取到的数据===%@",dataArr);
        }
        
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
            self.icarouselView.scrollToItem(at: index, animated: false)
            //请求数据
            self.viewManager.setInformation(index: index, type: infoType, isRefresh: false, data: { (dataArr) in
                let pageView = self.icarouselView.itemView(at: index) as! ZJFirstPageView
                pageView.pageDataArr = dataArr as! NSMutableArray
            })
        }
        segmentView.segmentTitleArr = ["图片","段子","声音","视频"]
        self.view.addSubview(segmentView)

        
        icarouselView = iCarousel.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: KScreenHight-64-49));
        icarouselView.delegate = self
        icarouselView.dataSource = self
        icarouselView.backgroundColor = UIColor.white
        icarouselView.type = .linear;
        icarouselView.decelerationRate = 0.75;
        icarouselView.isPagingEnabled = true;
        self.view.addSubview(icarouselView)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 8
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = ZJFirstPageView.init(frame: carousel.bounds) as ZJFirstPageView
        
        return view
    }

    /// 开始刷新
    func beginRefresh() {
//        viewManager.addAlamofireNetTest(isRefresh: true)
    }
    
}
