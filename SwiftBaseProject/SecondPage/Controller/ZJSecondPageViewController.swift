//
//  ZJSecondPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJSecondPageViewController: ZJBaseViewController ,iCarouselDelegate,iCarouselDataSource{

    var icarouselView = iCarousel()
    var carouselType = iCarouselType(rawValue: 0)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        carouselType =  iCarouselType(rawValue: Int(arc4random()%11))
        icarouselView.type = carouselType!;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "去哪"
        addIcarouselView()
    }
    
    func addIcarouselView()  {
        icarouselView = iCarousel.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: KScreenHight-64-49));
        icarouselView.delegate = self
        icarouselView.dataSource = self
        icarouselView.backgroundColor = UIColor.white
        icarouselView.type = .linear;
        icarouselView.decelerationRate = 0.75;
        icarouselView.isPagingEnabled = true;
        self.view.addSubview(icarouselView)
    }
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 8
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = UIView.init(frame: carousel.bounds)
        view.backgroundColor = UIColor.randomColor
        let label = UILabel.init(frame: carousel.bounds)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = "\(index+1)"
        label.font = UIFont.systemFont(ofSize: 40)
        view .addSubview(label)
        return view
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

