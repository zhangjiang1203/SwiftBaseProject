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

    var chooseType:NSInteger = 10
    
    var icarouselView = iCarousel()
    
    var viewManager = ZJCarouselManager()
    
    var segmentView = ZJSegmentScrollView()
    
    var carouselType = iCarouselType(rawValue: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carouselType =  iCarouselType(rawValue: Int(arc4random()%11))
        icarouselView.type = carouselType!;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        addIcarouselView()
    }
    
    func addIcarouselView()  {
        icarouselView = iCarousel.init(frame: CGRect.init(x: 0, y: 40, width: KScreenWidth, height: KScreenHight-64-49-40));
        icarouselView.delegate = self
        icarouselView.dataSource = self
        icarouselView.backgroundColor = UIColor.white
        icarouselView.type = .linear;
        icarouselView.decelerationRate = 0.75;
        icarouselView.isPagingEnabled = true;
        self.view.addSubview(icarouselView)
        
        viewManager = ZJCarouselManager.init()
        //设置分段器
        segmentView = ZJSegmentScrollView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 40))
        segmentView.selectedColor = RGBCOLOR_HEX(h: 0x00c866)
        segmentView.scrollClouse = {(index) in
            switch index {
            case 0:
                self.chooseType = 10
            case 1:
                self.chooseType = 29
            case 2:
                self.chooseType = 31
            case 3:
                self.chooseType = 41
            default:
                break;
            }
            self.icarouselView.scrollToItem(at: index, animated: false)
            //请求数据
            self.viewManager.setInformation(index: index, type: self.chooseType, isRefresh: false, data: { (dataArr) in
                let pageView = self.icarouselView.itemView(at: index) as! ZJFirstPageView
                pageView.pageDataArr = dataArr as! NSMutableArray
            })
        }
        segmentView.segmentTitleArr = ["图片","段子","声音","视频"]
        self.view.addSubview(segmentView)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 4
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = ZJFirstPageView.init(frame: carousel.bounds) as ZJFirstPageView
        view.refreshClouse = { (isRefresh) in
            //刷新和加载数据
            if isRefresh {
                self.viewManager.refreshInformation(index: index, type: self.chooseType, dataBlock: { (dataArr) in
                    let pageView = self.icarouselView.itemView(at: index) as! ZJFirstPageView
                    pageView.pageDataArr = dataArr as! NSMutableArray
                    view.gifHeader.endRefreshing()
                })
            }else{
                self.viewManager.loadMoreInformation(index: index, type: self.chooseType, dataBlock: { (dataArr) in
                    let pageView = self.icarouselView.itemView(at: index) as! ZJFirstPageView
                    pageView.pageDataArr = dataArr as! NSMutableArray
                    view.footerRefresh.endRefreshing()
                })
            }
        }
        return view
    }
    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        segmentView.setScrollToIndex(index: carousel.currentItemIndex)
    }    
}
