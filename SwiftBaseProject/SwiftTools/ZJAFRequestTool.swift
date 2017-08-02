//
//  ZJAFRequestTool.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/1.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import Alamofire


class ZJAFRequestTool {
    ///会话中心
    var session: SessionManager!
    /// 创建单例，添加() 表示立即执行
    static let shareInstance : ZJAFRequestTool = {
        let tools = ZJAFRequestTool()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30//请求时间限制
        tools.session = Alamofire.SessionManager(configuration: configuration)
        return tools
    }()
}


extension ZJAFRequestTool {
    /// get请求  类方法
    ///
    /// - Parameters:
    ///   - urlString: url
    ///   - params: 参数
    ///   - success: 成功回调
    ///   - failture: 失败回调
    class func getRequest(urlString: String, params : [String : Any], success : @escaping (_ response : AnyObject)->(), failture : @escaping (_ error : String)->()) {
        
        let url = try! URLHandler(name: urlString).asURL()
        //使用Alamofire进行网络请求时，调用该方法的参数都是通过getRequest(urlString， params, success :, failture :）传入的，而success传入的其实是一个接受           [String : AnyObject]类型 返回void类型的函数
        ZJAFRequestTool.shareInstance.session.request(url, method: .get, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success( _):
                //当响应成功是，使用临时变量value接受服务器返回的信息并判断是否为[String: AnyObject]类型 如果是那么将其传给其定义方法中的success
                if let value = response.result.value as? [String: AnyObject] {
                    success(value as AnyObject)
                }
            case .failure(let error):
                failture(error.localizedDescription)
                print("error:\(error)")
            }
        }
    }
    
    
    /// post请求  类方法
    ///
    /// - Parameters:
    ///   - urlString: url
    ///   - params: 参数
    ///   - success: 成功回调
    ///   - failture: 失败回调
    class func postRequest(urlString : String, params : [String : Any], success : @escaping (_ response : AnyObject)->(), failture : @escaping (_ error : String)->()) {
        
        let url = try! URLHandler(name: urlString).asURL()
        
        ZJAFRequestTool.shareInstance.session.request(url, method: HTTPMethod.post, parameters: params).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    success(value as AnyObject)
                }
            case .failure(let error):
                failture(error.localizedDescription)
            }
        }
    }
    
    //MARK: - 照片上传  类方法
    ///
    /// - Parameters:
    ///   - urlString: 服务器地址
    ///   - params: ["flag":"","userId":""] - flag,userId 为必传参数
    ///        flag - 666 信息上传多张  －999 服务单上传  －000 头像上传
    ///   - data: image转换成Data
    ///   - name: fileName
    ///   - success:
    ///   - failture:
    func upLoadImageRequest(urlString : String, params:[String:String], data: [Data], name: [String],success : @escaping (_ response : [String : AnyObject])->(), failture : @escaping (_ error : String)->()){
        
        let headers = ["content-type":"multipart/form-data"]
        
        ZJAFRequestTool.shareInstance.session.upload(
            multipartFormData: { multipartFormData in
                //666多张图片上传
                let flag = params["flag"]
                let userId = params["userId"]
                
                multipartFormData.append((flag?.data(using: String.Encoding.utf8)!)!, withName: "flag")
                multipartFormData.append( (userId?.data(using: String.Encoding.utf8)!)!, withName: "userId")
                
                for i in 0..<data.count {
                    multipartFormData.append(data[i], withName: "appPhoto", fileName: name[i], mimeType: "image/png")
                }
        },
            to: urlString,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        if let value = response.result.value as? [String: AnyObject]{
                            success(value)
                        }
                    }
                case .failure(let encodingError):
                    failture(encodingError.localizedDescription)
                }
        })
    }
}



/// 处理url转化
class URLHandler {
    var paramURL:String!
    init(name:String) {
        paramURL = name
    }
}

extension URLHandler: URLConvertible {
    //添加网络请求baseURL
    static let baseURLString = ""
    func asURL() throws -> URL {
        let urlString = URLHandler.baseURLString + paramURL
        return try urlString.asURL()
    }
}


