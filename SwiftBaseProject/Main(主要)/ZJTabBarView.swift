//
//  ZJTabBarView.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

//定义代理
protocol ZJTabBarDelegate:NSObjectProtocol{
    
    func buttonIndexClick(index:NSInteger)
    
}

//定义闭包 传值
typealias ButtonClickClosure = (NSInteger) -> Void


class ZJTabBarView: UIView {

    fileprivate var titleArr = NSMutableArray()
    fileprivate var norImageArr = NSMutableArray()
    fileprivate var selImageArr = NSMutableArray()
    
    fileprivate var selectedBtn = UIButton()
    
    fileprivate let norColor = RGBCOLOR_HEX(h: 0x494949)
    fileprivate let selColor = RGBCOLOR_HEX(h: 0x00c866)
    fileprivate let kButtonTag = 10
    
    var delegate:ZJTabBarDelegate?
    var clickAction:ButtonClickClosure?//定义闭包值
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleArr.addObjects(from: ["首页","图书","汽车","其他"])
        norImageArr.addObjects(from: ["swift_first_nor","swift_book_nor","swift_car_nor","swift_other_nor"])
        selImageArr.addObjects(from: ["swift_first_sel","swift_book_sel","swift_car_sel","swift_other_sel"])
        addTouchButton()
        //默认选中第一个
        buttonClickAction(sender: self.viewWithTag(kButtonTag) as! UIButton)
    }
    
    //添加按钮
    func addTouchButton()  {
        let buttonW = KScreenWidth/CGFloat(titleArr.count)
        
        for i in 0..<titleArr.count {
            let button = UIButton.init(frame: CGRect.init(x: buttonW * CGFloat(i), y: 0, width: buttonW, height: 49))
            button.setImage(UIImage.init(named: norImageArr[i] as! String), for: .normal)
            button.setImage(UIImage.init(named: selImageArr[i] as! String), for: .selected)
            button.setTitleColor(norColor, for: .normal)
            button.setTitleColor(selColor, for: .selected)
            button.tag = kButtonTag + i
            button.addTarget(self, action: #selector(buttonClickAction(sender:)), for: .touchUpInside)
            self.addSubview(button)
        }
    }
    
    func buttonClickAction(sender:UIButton)  {
        selectedBtn.isSelected = false
        sender.isSelected = true
        selectedBtn = sender
        if (clickAction != nil)  {
            clickAction!(sender.tag-kButtonTag)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
