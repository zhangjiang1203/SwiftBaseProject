//
//  ZJFirstPageCell.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/7.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit
import Kingfisher

class ZJFirstPageCell: UITableViewCell {

    
    @IBOutlet weak var userHeaderImage: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var detailContentLabel: UILabel!
    
    @IBOutlet weak var infoImageView: UIImageView!
    
    @IBOutlet weak var infoImageCons: NSLayoutConstraint!
    var listData = List(){
        didSet{
            setMyListShowData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userHeaderImage.zy_cornerRadiusRoundingRect()
        infoImageView.setImageFitWithImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //开始设置显示的数据信息
    func setMyListShowData()  {
        self.userHeaderImage.sd_setImage(with: URL.init(string: listData.profile_image!), placeholderImage: UIImage.init(named: "defaultUserheader"))
        self.userNameLabel.text = listData.name
        self.detailContentLabel.text = listData.text
        
        if listData.image0 != nil {
            self.infoImageView.sd_setImage(with: URL.init(string:listData.image0!), placeholderImage: UIImage.init(named: ""))
            infoImageCons.constant = 160
        }else{
            infoImageCons.constant = 0
        }
        let tempDate:Array<String> = [listData.love!,listData.hate!,listData.repost!,listData.comment!]
        for i in 1...tempDate.count {
            let button:UIButton = self.viewWithTag(i) as! UIButton
            button.setTitle(String.init(format: " %@", tempDate[i-1]) , for: .normal)
        }

    }
}
