//
//  ZJForthManager.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/29.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import HandyJSON

class ZJForthManager: NSObject {

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
    fileprivate var page10 = 1
    fileprivate var page11 = 1
    fileprivate var page12 = 1
    fileprivate var page13 = 1
    fileprivate var page14 = 1
    fileprivate var page15 = 1
    fileprivate var page16 = 1
    fileprivate var page17 = 1
    fileprivate var page18 = 1
    fileprivate var page19 = 1
    fileprivate var page20 = 1
    fileprivate var page21 = 1
    fileprivate var page22 = 1
    fileprivate var page23 = 1
    fileprivate var page24 = 1
    fileprivate var page25 = 1
    fileprivate var page26 = 1
    fileprivate var page27 = 1
    fileprivate var page28 = 1
    fileprivate var page29 = 1
    fileprivate var page30 = 1
    fileprivate var page31 = 1
    fileprivate var page32 = 1
    fileprivate var page33 = 1
    fileprivate var page34 = 1
    fileprivate var page35 = 1
    fileprivate var page36 = 1
    fileprivate var page37 = 1
    fileprivate var page38 = 1
    fileprivate var page39 = 1
    
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
    fileprivate var infoDataArr10 = NSMutableArray()
    fileprivate var infoDataArr11 = NSMutableArray()
    fileprivate var infoDataArr12 = NSMutableArray()
    fileprivate var infoDataArr13 = NSMutableArray()
    fileprivate var infoDataArr14 = NSMutableArray()
    fileprivate var infoDataArr15 = NSMutableArray()
    fileprivate var infoDataArr16 = NSMutableArray()
    fileprivate var infoDataArr17 = NSMutableArray()
    fileprivate var infoDataArr18 = NSMutableArray()
    fileprivate var infoDataArr19 = NSMutableArray()
    fileprivate var infoDataArr20 = NSMutableArray()
    fileprivate var infoDataArr21 = NSMutableArray()
    fileprivate var infoDataArr22 = NSMutableArray()
    fileprivate var infoDataArr23 = NSMutableArray()
    fileprivate var infoDataArr24 = NSMutableArray()
    fileprivate var infoDataArr25 = NSMutableArray()
    fileprivate var infoDataArr26 = NSMutableArray()
    fileprivate var infoDataArr27 = NSMutableArray()
    fileprivate var infoDataArr28 = NSMutableArray()
    fileprivate var infoDataArr29 = NSMutableArray()
    fileprivate var infoDataArr30 = NSMutableArray()
    fileprivate var infoDataArr31 = NSMutableArray()
    fileprivate var infoDataArr32 = NSMutableArray()
    fileprivate var infoDataArr33 = NSMutableArray()
    fileprivate var infoDataArr34 = NSMutableArray()
    fileprivate var infoDataArr35 = NSMutableArray()
    fileprivate var infoDataArr36 = NSMutableArray()
    fileprivate var infoDataArr37 = NSMutableArray()
    fileprivate var infoDataArr38 = NSMutableArray()
    fileprivate var infoDataArr39 = NSMutableArray()
    
    //添加绑定的数据
    fileprivate var indexsArr = NSMutableArray()
    fileprivate var pagesArr = NSMutableArray()
    
    override init() {
        super.init()
        setOrignalDataArr()
        setOrignalDataPage()
    }
    
    /// 初始化数据数组
    fileprivate func setOrignalDataArr()  {
        indexsArr.addObjects(from: [infoDataArr0,infoDataArr1,infoDataArr2,infoDataArr3,infoDataArr4,infoDataArr5,infoDataArr6,infoDataArr7,infoDataArr8,infoDataArr9,infoDataArr10,infoDataArr11,infoDataArr12,infoDataArr13,infoDataArr14,infoDataArr15,infoDataArr16,infoDataArr17,infoDataArr18,infoDataArr19,infoDataArr20,infoDataArr21,infoDataArr22,infoDataArr23,infoDataArr24,infoDataArr25,infoDataArr26,infoDataArr27,infoDataArr28,infoDataArr29,infoDataArr30,infoDataArr31,infoDataArr32,infoDataArr33,infoDataArr34,infoDataArr35,infoDataArr36,infoDataArr37,infoDataArr38,infoDataArr39])
    }
    
    /// 初始化当前页数数组
    fileprivate func setOrignalDataPage() {
        pagesArr.addObjects(from: [page0,page1,page2,page3,page4,page5,page6,page7,page8,page9,page10,page11,page12,page13,page14,page15,page16,page17,page18,page19,page20,page21,page22,page23,page24,page25,page26,page27,page28,page29,page30,page31,page32,page33,page34,page35,page36,page37,page38,page39])
    }
    
    /// 获取当前index对应的数组
    ///
    /// - Parameter index: 当前下标
    /// - Returns: 返回值
    fileprivate func getIndexArray(index:NSInteger) -> NSMutableArray {
        indexsArr.removeAllObjects()
        setOrignalDataArr()
        return indexsArr[index] as! NSMutableArray
    }
    
    /// 获取当前index对应的page
    ///
    /// - Parameter index: 当前下标
    /// - Returns: 返回值
    fileprivate func getPage(index:NSInteger) -> NSInteger {
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
            ZJAFRequestTool.getRequest(urlString: "http://apicloud.mob.com/wx/article/search", params: ["cid":type,"page":pageStr,"key":KShareSDKKey,"size":20], success: { (result) in
                
                let code = result["retCode"] as! NSString
                if code.isEqual(to: "200") {
                    if let model = JSONDeserializer<ZJForthModel>.deserializeFrom(dict: result as? NSDictionary){
                        let dataArr = self.getIndexArray(index: index)
                        if dataArr.count > 0 && isRefresh {
                            dataArr.removeAllObjects()
                            self.indexsArr.replaceObject(at: index, with: dataArr)
                        }
                        //处理之后的数组
                        let detailArr = self.getIndexArray(index: index)
                        detailArr.addObjects(from: (model.result?.list!)!)
                        self.indexsArr.replaceObject(at: index, with: detailArr)
                        dataBlock(self.getIndexArray(index: index))
                    }
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
