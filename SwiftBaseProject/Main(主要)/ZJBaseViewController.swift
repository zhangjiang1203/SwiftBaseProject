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
        addFlurBackImage()
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
