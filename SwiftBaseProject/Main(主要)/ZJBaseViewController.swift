//
//  ZJBaseViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/7/31.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setLeftBackButtonItem()
    }
    
    //添加返回的按钮
    func setLeftBackButtonItem()  {
        
        let leftButton = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        leftButton.addTarget(self, action: #selector(backToBeforeVC), for: .touchUpInside)
        leftButton.setImage(UIImage.init(named:"back_press_black"), for: .normal)
        leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        leftButton.imageView?.contentMode = .left
        
        let leftBar = UIBarButtonItem.init(customView: leftButton)
        let navSpaceBar = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        navSpaceBar.width = 3
        self.navigationItem.leftBarButtonItems = [navSpaceBar,leftBar]
    }
    
    func backToBeforeVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addFlurBackImage()  {
        //添加背景图片
        let backImageView = UIImageView.init(frame: self.view.bounds)
        backImageView.image = UIImage.init(named: "locationBGImage")
        self.view.addSubview(backImageView)
        //添加模糊背景
        let effect = UIBlurEffect.init(style: .light)
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = self.view.bounds
        self.view.addSubview(effectView)
    }

}
