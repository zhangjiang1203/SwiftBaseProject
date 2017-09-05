//
//  publicDefineMethod.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import Foundation
import UIKit
import HandyJSON

//定义一些常用的常量
let KScreenWidth = UIScreen.main.bounds.size.width;
let KScreenHight = UIScreen.main.bounds.size.height;

let KShareSDKKey = "10318870f4a99"


/*
 默认颜色
 */
func RGBColor(r :CGFloat ,g:CGFloat,b:CGFloat) ->UIColor{
    return UIColor.init(colorLiteralRed: Float(r / 255.0), green:Float(g / 255.0) , blue:Float (b / 255.0), alpha: 1)
}

func RGBCOLOR_HEX(h:Int) ->UIColor {
    return RGBColor(r: CGFloat(((h)>>16) & 0xFF), g:CGFloat(((h)>>8) & 0xFF), b:  CGFloat((h) & 0xFF))
}

//计算字符高度
extension String {
    func getSuitSizeWithFont(font:UIFont,width:CGFloat) -> CGFloat {
        let size = CGSize.init(width: width, height: CGFloat.greatestFiniteMagnitude)
        let showStr = self as NSString
        let contentH = showStr.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil).size.height
        return contentH
    }
}

extension UIColor {
    //返回随机颜色
    class var randomColor: UIColor {
        get {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}


