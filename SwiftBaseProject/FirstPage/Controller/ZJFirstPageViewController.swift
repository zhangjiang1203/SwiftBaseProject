//
//  ZJFirstPageViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

import ReactiveSwift
import Result

class ZJFirstPageViewController: ZJBaseViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    var viewManager:ZJFirstPageManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        addMySegmentInit()
        
    }
    

    func SwiftRACTest()  {
        
        let (signalA ,observerA) = Signal<String,NoError>.pipe()
        let (signalB ,observerB) = Signal<String,NoError>.pipe()
        
        Signal.combineLatest(signalA,signalB).observeValues { (values) in
            print("收到的值\(values.0)+\(values.1)")
        }
        
        observerA.send(value: "1")
        observerA.sendCompleted()
        
        observerB.send(value: "2")
        observerB.sendCompleted()
    }
    
    func addMySegmentInit()  {
        
        viewManager = ZJFirstPageManager.init()
        viewManager.showTableView = myTableView
        
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "systemCell")
        myTableView.delegate = viewManager
        myTableView.dataSource = viewManager
        
        let segmentView = ZJSegmentScrollView.init(frame: CGRect.init(x: 0, y: 0, width: KScreenWidth, height: 40))
        segmentView.selectedColor = RGBCOLOR_HEX(h: 0x00c866)
        segmentView.scrollClouse = {(index) in
            print("index====\(index)")
            var infoType = 0
            switch index {
            case 0:
                infoType = 10
            case 1:
                infoType = 29
            case 2:
                infoType = 31
            case 3:
                infoType = 41
            default:
                break;
            }
            self.viewManager.infoType = infoType
        }
        segmentView.segmentTitleArr = ["图片","段子","声音","视频"]
        self.view.addSubview(segmentView)
    }
    
}
