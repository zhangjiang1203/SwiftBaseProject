//
//  ZJBookDetailViewController.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/22.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJBookDetailViewController: ZJBaseViewController {

    var bookModel :Books!
    
    @IBOutlet weak var backTopView: UIView!
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    @IBOutlet weak var bookPriceLabel: UILabel!
    @IBOutlet weak var bookPublisherLabel: UILabel!
    @IBOutlet weak var bookBriefLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let summaryH = bookModel.summary?.getSuitSizeWithFont(font: UIFont.systemFont(ofSize: 14), width: KScreenWidth-40)
        backTopView.mj_h = summaryH! + 190
        //开始赋值
        bookImageView.sd_setImage(with: URL.init(string: bookModel.image!), placeholderImage: UIImage.init(named: ""))
        bookNameLabel.text = bookModel.title
        bookAuthorLabel.text = bookModel.author?.joined(separator: ",")
        bookPriceLabel.text = bookModel.price?.characters.count != 0 ? String.init(format: "售价:%@",bookModel.price!):"暂无定价"
        bookPublisherLabel.text = String.init(format: "出版社:%@",bookModel.publisher!)
        bookBriefLabel.text = (bookModel.summary?.characters.count)! > 0 ? bookModel.summary : "该图书暂无说明"
    }
    
    @IBAction func checkBookWebShow(_ sender: UIButton) {
        
        if let url = NSURL(string:bookModel.alt!)  {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }
        
        
    }
}
