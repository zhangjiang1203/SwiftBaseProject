//
//  ZJRequestTool.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/1.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import Moya

enum RequestModel {
    case login(account:String,pwd:String)
    case register(phone:String,nickName:String,pwd:String)
    case cancel
    
}


extension RequestModel:TargetType{
    // 网络请求baseURL
    var baseURL: URL{
        return NSURL.init(string: "")! as URL
    }
    //网络请求路径
    var path: String{
        switch self {
        case .login(_, _):
            return "service/login"
        case .register(_, _, _):
            return "service/register"
        case .cancel:
            return "service/cancel"
        }
    }
    //网络请求方法类型
    var method: Moya.Method{
        return .post
    }
    //返回的参数
    var parameters: [String : Any]?{
        switch self {
        case .login(let account,let pwd):
            return ["name":account,"pwd":pwd];
        case .register(let phone,let nickName,let pwd):
            return ["phone":phone,"nickName":nickName,"pwd":pwd]
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding{
        return JSONEncoding.default
    }
    
    var sampleData: Data{
        return "".data(using: .utf8)!
    }
    
    var task: Task{
        return .request
    }
}


class ZJRequestTool: NSObject {

}
