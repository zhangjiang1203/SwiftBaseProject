//
//  ZJSegmentScrollView.swift
//  013-SwiftPracticeDemo
//
//  Created by pg on 2017/7/13.
//  Copyright © 2017年 DZHFCompany. All rights reserved.
//

import UIKit

//定义协议
protocol ZJSegmentDelegate : NSObjectProtocol {
    
    /// 当前点击的按钮
    ///
    /// - Parameter index: 当前的返回值
    func segmentClickAction(index:NSInteger)
}


class ZJSegmentScrollView: UIView ,UIScrollViewDelegate{
    
    var lineWidth:CGFloat = 40{
        didSet{
            var lineFrame = lineView.frame
            lineFrame.origin.x = (maxWidth - lineWidth)/2
            lineFrame.size.width = lineWidth
            lineView.frame = lineFrame
        }
    }
    var lineHeight:CGFloat = 2{
        didSet{
            var lineFrame = lineView.frame
            lineFrame.origin.y = viewSize.height - lineHeight
            lineFrame.size.height = lineHeight
            lineView.frame = lineFrame
        }
    }
    var buttonFont:UIFont = UIFont.systemFont(ofSize: 15){
        didSet{
            for view in myScrollView.subviews.enumerated(){
                if view.element.isKind(of: UIButton.self) {
                    let button = view.element as! UIButton
                    button.titleLabel?.font = buttonFont
                }
            }
        }
    }
    
    var normalColor:UIColor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1){
        didSet{
            for view in myScrollView.subviews.enumerated(){
                if view.element.isKind(of: UIButton.self) {
                    let button = view.element as! UIButton
                    button.setTitleColor(normalColor, for: .normal)
                }
            }

        }
    }
    var selectedColor:UIColor = UIColor.init(red: 1, green: 0, blue: 0, alpha: 1){
        didSet{
            for view in myScrollView.subviews.enumerated(){
                if view.element.isKind(of: UIButton.self) {
                    let button = view.element as! UIButton
                    button.setTitleColor(selectedColor, for: .selected)
                }
            }
            self.lineView.backgroundColor = selectedColor
        }
    }
    //开始设置数据
    var segmentTitleArr:Array<NSString> = []{
        didSet{
            createMyScrollViewTitleString()
        }
    }

    //代理传值
    var delegate:ZJSegmentDelegate?
    
    //定义参数
    fileprivate var viewSize:CGSize!
    fileprivate var myScrollView:UIScrollView!
    fileprivate var selectedBtn = UIButton()
    fileprivate var lineView:UIView!
    fileprivate var maxWidth:CGFloat = 0
    fileprivate var selectTag = 0
    fileprivate let animationTime = 0.5
    //定义一个闭包传值
    var scrollClouse:((_ index:NSInteger) -> Void)!
    //当前所在索引
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewSize = frame.size
        setUpMySegmentView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewSize = self.bounds.size
        setUpMySegmentView()
    }
    
    fileprivate func setUpMySegmentView()  {
        myScrollView = UIScrollView.init(frame: self.bounds)
        myScrollView.showsVerticalScrollIndicator = false
        myScrollView.showsHorizontalScrollIndicator = false
        myScrollView.delegate = self
        self.addSubview(myScrollView);
        
        //添加底部固定横线
        let bottomLineView = UIView.init(frame: CGRect.init(x: 0, y: self.bounds.size.height-1, width: self.bounds.size.width, height: 1))
        bottomLineView.backgroundColor = UIColor.init(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        myScrollView.addSubview(bottomLineView)
        
        //添加滚动横线
        lineView = UIView.init(frame: CGRect.init(x: (maxWidth-lineWidth)/2.0, y: viewSize.height-lineHeight, width: lineWidth, height: lineHeight))
        lineView.backgroundColor = selectedColor
        myScrollView.addSubview(lineView)
    }
    //添加标签
    fileprivate func createMyScrollViewTitleString()  {
        var titleWidthArr:Array<CGFloat> = []
        //计算字符的宽度
        for num in segmentTitleArr.enumerated() {
            titleWidthArr.append(calCharacterWith(num.element, font: buttonFont, height: viewSize.height))
        }
        
        //取出数组中的最大值
        for width in titleWidthArr {
            if maxWidth < width {
                maxWidth = width
            }
        }

        maxWidth = maxWidth*CGFloat(titleWidthArr.count) > viewSize.width ? maxWidth:(viewSize.width/CGFloat(titleWidthArr.count))
        myScrollView.contentSize = CGSize.init(width: maxWidth*CGFloat(titleWidthArr.count), height: viewSize.height)

        //添加按钮设置数据
        for item in segmentTitleArr.enumerated() {
            let button = UIButton.init(frame: CGRect.init(x: CGFloat(item.offset)*maxWidth, y: 0, width: maxWidth, height: viewSize.height))
            button.setTitle(item.element as String, for: .normal)
            button.setTitleColor(normalColor, for: .normal)
            button.setTitleColor(selectedColor, for: .selected)
            button.titleLabel?.font = buttonFont
            button.addTarget(self, action: #selector(segmentButtonClick(sender:)), for: .touchUpInside)
            button.tag = item.offset + 10
            myScrollView.addSubview(button)
            
        }
        //添加横线
        lineView.frame = CGRect.init(x: (maxWidth-lineWidth)/2.0, y: viewSize.height-lineHeight, width: lineWidth, height: lineHeight)
        let button = self.viewWithTag(10) as! UIButton
        segmentButtonClick(sender: button)
    }
    
    
    @objc fileprivate func segmentButtonClick(sender:UIButton)  {
        sender.isSelected = true
        selectedBtn.isSelected = false
        selectedBtn = sender;
        
        //修改lineView的frame
        var lineRect = self.lineView.frame
        
        if selectTag < sender.tag {
            lineRect.size.width = sender.frame.midX-lineRect.midX+lineWidth
            UIView.animate(withDuration: animationTime/2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 9, options: .curveEaseInOut, animations: { 
                self.lineView.frame = lineRect
            }, completion: { (finish) in
                lineRect.size.width = self.lineWidth
                lineRect.origin.x = sender.frame.midX-self.lineWidth/2
                UIView.animate(withDuration: self.animationTime/2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 9, options: .curveEaseOut, animations: {
                    self.lineView.frame = lineRect
                }, completion: nil)
            })
        }else{
            lineRect.origin.x = sender.frame.midX-lineWidth/2;
            let button = self.viewWithTag(selectTag) as! UIButton
            lineRect.size.width = button.frame.midX - sender.frame.midX+lineWidth
            UIView.animate(withDuration: animationTime/2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 9, options: .curveEaseInOut, animations: {
                self.lineView.frame = lineRect
            }, completion: { (finish) in
                lineRect.size.width = self.lineWidth
                UIView.animate(withDuration: self.animationTime/2, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 9, options: .curveEaseOut, animations: {
                    self.lineView.frame = lineRect
                }, completion: nil)
            })

        }
        selectTag = sender.tag
        setScrollOffset(index: sender.tag)
        //代理传值
        delegate?.segmentClickAction(index: sender.tag-10)
        
        if scrollClouse != nil{
            scrollClouse(sender.tag - 10)
        }
    }
    
    
    func setScrollToIndex(index:NSInteger) {
        let button = self.viewWithTag(index+10) as! UIButton
        segmentButtonClick(sender: button)
    }
    
    //scrollView滚动
    fileprivate func setScrollOffset(index:NSInteger) {
        let button = self.viewWithTag(index)
        let rect:CGRect = (button?.frame)!
        let midX = rect.midX
        var offset = 0.0
        let contentwidth = myScrollView.contentSize.width
        let halfWidth = self.bounds.width/2.0
        
        if midX < halfWidth  {
            offset = 0
        }else if (midX > contentwidth-halfWidth){
            offset = Double(contentwidth - 2*halfWidth)
        }else{
            offset = Double(midX - halfWidth)
        }
        
        UIView.animate(withDuration: animationTime) { 
            self.myScrollView.setContentOffset(CGPoint.init(x: offset, y: 0), animated: false)
        }
    }
    
    
    //计算文字的宽度
    fileprivate func calCharacterWith(_ title:NSString, font:UIFont, height:CGFloat) -> CGFloat {
        
        let width = title.boundingRect(with: CGSize.init(width: CGFloat.greatestFiniteMagnitude, height:height), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil).size.width+10
        
        return width
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

