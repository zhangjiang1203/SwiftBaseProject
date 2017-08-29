//
//  ZJForthPageCell.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/29.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJForthPageCell: UITableViewCell {

    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var imageWidthCons: NSLayoutConstraint!
    
    var listModel = MyList(){
        didSet{
            //设置信息
            newsTitleLabel.text = listModel.title
            timeLabel.text = listModel.pubTime
            if (listModel.thumbnails != nil) {
                self.imageWidthCons.constant = 60
                self.newsImageView.sd_setImage(with: URL.init(string: self.listModel.thumbnails!), placeholderImage: UIImage.init(named: ""))
            }else{
                self.imageWidthCons.constant = 0
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageView.setContentImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
