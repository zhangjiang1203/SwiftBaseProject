//
//  ZJCarouselManager.swift
//  SwiftBaseProject
//
//  Created by pg on 2017/8/17.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import Alamofire
import HandyJSON


class ZJCarouselManager: NSObject {

    //添加初始值
    fileprivate var page0 = 1
    fileprivate var page1 = 1
    fileprivate var page2 = 1
    fileprivate var page3 = 1
    fileprivate var page4 = 1
    fileprivate var page5 = 1
    fileprivate var page6 = 1
    fileprivate var page7 = 1
    fileprivate var page8 = 1
    fileprivate var page9 = 1
    
    //添加数组
    fileprivate var infoDataArr0 = NSMutableArray()
    fileprivate var infoDataArr1 = NSMutableArray()
    fileprivate var infoDataArr2 = NSMutableArray()
    fileprivate var infoDataArr3 = NSMutableArray()
    fileprivate var infoDataArr4 = NSMutableArray()
    fileprivate var infoDataArr5 = NSMutableArray()
    fileprivate var infoDataArr6 = NSMutableArray()
    fileprivate var infoDataArr7 = NSMutableArray()
    fileprivate var infoDataArr8 = NSMutableArray()
    fileprivate var infoDataArr9 = NSMutableArray()
    
    //添加绑定的数据
    fileprivate var indexsArr = NSMutableArray()
    fileprivate var pagesArr = NSMutableArray()

    override init() {
        super.init()
        setOrignalDataArr()
        setOrignalDataPage()
    }
    
    /// 初始化数据数组
    func setOrignalDataArr()  {
        indexsArr.addObjects(from: [infoDataArr0,infoDataArr1,infoDataArr2,infoDataArr3,infoDataArr4,infoDataArr5,infoDataArr6,infoDataArr7,infoDataArr8,infoDataArr9])
    }
    
    /// 初始化当前页数数组
    func setOrignalDataPage() {
        pagesArr.addObjects(from: [page0,page1,page2,page3,page4,page5,page6,page7,page8,page9])
    }
    
    /// 获取当前index对应的数组
    ///
    /// - Parameter index: 当前下标
    /// - Returns: 返回值
    func getIndexArray(index:NSInteger) -> NSMutableArray {
        indexsArr.removeAllObjects()
        setOrignalDataArr()
        return indexsArr[index] as! NSMutableArray
    }
    
    /// 获取当前index对应的page
    ///
    /// - Parameter index: 当前下标
    /// - Returns: 返回值
    func getPage(index:NSInteger) -> NSInteger {
        pagesArr.removeAllObjects()
        setOrignalDataPage()
        return pagesArr[index] as! NSInteger
    }
    
    /// 首次请求数据
    ///
    /// - Parameters:
    ///   - index: 第几个
    ///   - type: 请求类型
    ///   - isRefresh: 是否是刷新
    ///   - data: 返回的数据
    func setInformation(index:NSInteger, type:NSInteger, isRefresh:Bool, data:@escaping (NSArray)->Void) {
        getInformation(index: index, type: type, isRefresh: isRefresh, dataBlock: data)
    }
    
    /// 刷新数据
    ///
    /// - Parameters:
    ///   - index: 第几个
    ///   - type: 什么类型
    ///   - dataBlock: 返回的数据
    func refreshInformation(index:NSInteger,type:NSInteger,dataBlock:@escaping (NSArray)->Void) {
        getInformation(index: index, type: type, isRefresh: true, dataBlock: dataBlock)
    }
    
    /// 加载更多数据
    ///
    /// - Parameters:
    ///   - index: 当前第几个
    ///   - type: 请求类型
    ///   - dataBlock: 返回的数据
    func loadMoreInformation(index:NSInteger,type:NSInteger,dataBlock:@escaping (NSArray)->Void)  {
        getInformation(index: index, type: type, isRefresh: false, dataBlock: dataBlock)
    }
    
    
    /// 请求网络信息
    ///
    /// - Parameters:
    ///   - index: 当前第几个
    ///   - type: 请求类型
    ///   - isRefresh: 是否是刷新
    ///   - dataBlock: 返回的数据
    fileprivate func getInformation(index:NSInteger,type:NSInteger,isRefresh:Bool,dataBlock:@escaping (NSArray)->Void)  {
        
        setMyParams(index: index, type: type, isRefresh: isRefresh) { (pageStr) in
            //开始请求数据
            ZJAFRequestTool.getRequest(urlString: "http://api.budejie.com/api/api_open.php?a=list&c=data", params: ["type":type,"page":pageStr], success: { (result) in
                if let model = JSONDeserializer<ZJRequestTestModel>.deserializeFrom(dict: result as? NSDictionary){
                    let dataArr = self.getIndexArray(index: index)
                    if dataArr.count > 0 && isRefresh {
                        dataArr.removeAllObjects()
                        self.indexsArr.replaceObject(at: index, with: dataArr)
                    }
                    //处理之后的数组
                    let detailArr = self.getIndexArray(index: index)
                    detailArr.addObjects(from: model.list!)
                    self.indexsArr.replaceObject(at: index, with: detailArr)
                    dataBlock(self.getIndexArray(index: index))
                }
            }) { (errorStr) in
                print("错误信息===\(errorStr)")
            }

        }
    }
    
    /// 设置请求参数
    ///
    /// - Parameters:
    ///   - index: 当前是第几个
    ///   - type: 请求类型
    ///   - isRefresh: 是否是刷新
    ///   - params: 返回的参数
    fileprivate func setMyParams(index:NSInteger,type:NSInteger,isRefresh:Bool,params:(NSString)->Void) {
        var page = 1;
        if !isRefresh {
            page = getPage(index: index)
            page = page + 1
            pagesArr.replaceObject(at: index, with: page)
        }
        params("\(page)" as NSString)
    }
}
