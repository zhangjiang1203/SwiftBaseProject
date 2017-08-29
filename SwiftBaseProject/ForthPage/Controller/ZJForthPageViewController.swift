//
//  ZJForthPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJForthPageViewController: ZJBaseViewController,iCarouselDelegate,iCarouselDataSource {
    
    var segmentTitleArr = [Dictionary<String, NSString>]()

    var segmentView = ZJSegmentScrollView()
    
    var icarouselView = iCarousel()
    
    var viewManager = ZJForthManager()
    
    var chooseType:NSInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "其他"
        self.navigationItem.leftBarButtonItems = nil
        setMyShowView()
        getWeiXinSegmentData()
    }
    
    func setMyShowView()  {
        
        icarouselView = iCarousel.init(frame: CGRect.init(x: 0, y: 40, width: KScreenWidth, height: KScreenHight-64-40));
        icarouselView.delegate = self
        icarouselView.dataSource = self
        icarouselView.backgroundColor = UIColor.white
        icarouselView.type = .linear;
        icarouselView.decelerationRate = 0.75;
        icarouselView.isPagingEnabled = true;
        self.view.addSubview(icarouselView)
        
        viewManager = ZJForthManager.init()
        //设置分段器
        segmentView = ZJSegmentScrollView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 40))
        segmentView.selectedColor = RGBCOLOR_HEX(h: 0x00c866)
        segmentView.scrollClouse = {(index) in
            let dict = self.segmentTitleArr[index]
            self.chooseType = (dict["cid"]?.integerValue)!
            self.icarouselView.scrollToItem(at: index, animated: false)
            //请求数据
            self.viewManager.setInformation(index: index, type: self.chooseType, isRefresh: false, data: { (dataArr) in
                let pageView = self.icarouselView.itemView(at: index) as! ZJForthPageView
                pageView.showDataArr = dataArr
            })
        }
        self.view.addSubview(segmentView)
    }
    
    func getWeiXinSegmentData() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ZJAFRequestTool.getRequest(urlString: "http://apicloud.mob.com/wx/article/category/query", params: ["key":KShareSDKKey], success: { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            //解析信息
            let dict = response as! NSDictionary
            self.segmentTitleArr = dict["result"] as! [Dictionary]
            var titleArr = [NSString]()
            for myData in self.segmentTitleArr {
                titleArr.append(myData["name"]!)
            }
            self.segmentView.segmentTitleArr = titleArr
            self.icarouselView.reloadData()
        }) { (errorStr) in
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return self.segmentTitleArr.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let dataView = ZJForthPageView.init(frame: carousel.bounds)
        dataView.parentVC = self
        dataView.refreshClouse = {(isRefresh) in
            if isRefresh{//重新请求数据
                self.viewManager.refreshInformation(index: index, type: self.chooseType, dataBlock: { (dataArr) in
                    let pageView = self.icarouselView.itemView(at: index) as! ZJForthPageView
                    pageView.showDataArr = dataArr 
                    pageView.headerRefresh.endRefreshing()
                })
            }else{
                self.viewManager.loadMoreInformation(index: index, type: self.chooseType, dataBlock: { (dataArr) in
                    let pageView = self.icarouselView.itemView(at: index) as! ZJForthPageView
                    pageView.showDataArr = dataArr
                    pageView.headerRefresh.endRefreshing()
                })
            }
        }
        return dataView
    }
    
    func carouselDidEndScrollingAnimation(_ carousel: iCarousel) {
        segmentView.setScrollToIndex(index: carousel.currentItemIndex)
    }

}
