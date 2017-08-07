//
//  ZJFirstPageCell.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/7.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

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
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //开始设置显示的数据信息
    func setMyListShowData()  {
        
    }
}
