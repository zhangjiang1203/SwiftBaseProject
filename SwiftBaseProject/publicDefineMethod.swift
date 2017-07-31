//
//  publicDefineMethod.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import Foundation
import UIKit

//定义一些常用的常量
let KScreenWidth = UIScreen.main.bounds.size.width;
let KScreenHight = UIScreen.main.bounds.size.height;


/*
 默认颜色
 */
func RGBColor(r :CGFloat ,g:CGFloat,b:CGFloat) ->UIColor{
    return UIColor.init(colorLiteralRed: Float(r / 255.0), green:Float(g / 255.0) , blue:Float (b / 255.0), alpha: 1)
}

func RGBCOLOR_HEX(h:Int) ->UIColor {
    return RGBColor(r: CGFloat(((h)>>16) & 0xFF), g:CGFloat(((h)>>8) & 0xFF), b:  CGFloat((h) & 0xFF))
}



