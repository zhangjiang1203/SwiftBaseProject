//
//  String+Height.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/8.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import Foundation

extension String {
    
    /// 计算字符串的高度
    ///
    /// - Parameters:
    ///   - attribute: 字符串属性
    ///   - fixedWidth: 字符串显示的宽度
    /// - Returns: 返回的高度值
    func heightWithStringAttribute(attribute:[String:AnyObject],fixedWidth:CGFloat) -> CGFloat {
        guard self.characters.count > 0 && fixedWidth > 0 else {
            return 0
        }
        
        let size = CGSize.init(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
        return rect.size.height+5
    }
    
    /// 计算字符串宽度
    ///
    /// - Parameters:
    ///   - attribute: 字符串属性
    ///   - fixedHeight: 字符串显示高度
    /// - Returns: 返回的宽度值
    func widthWithStringAttribute(attribute:[String:AnyObject],fixedHeight:CGFloat) -> CGFloat {
        guard self.characters.count > 0 && fixedHeight > 0 else {
            return 0
        }
        
        let size = CGSize.init(width: CGFloat.greatestFiniteMagnitude, height:fixedHeight)
        let text = self as NSString
        let rect = text.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attribute, context: nil)
        return rect.size.width+5
    }
}


extension UIImageView{
    
    /// 防止图片变形 自适应
    func setContentImageView() {
        self.contentScaleFactor = UIScreen.main.scale
        self.contentMode = .scaleToFill
        self.autoresizingMask = .flexibleHeight
        self.clipsToBounds = true
    }
}
