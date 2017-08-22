//
//  ZJShowBookCell.swift
//  SwiftBaseProject
//
//  Created by DFHZ on 2017/8/22.
//  Copyright © 2017年 DFHZ. All rights reserved.
//

import UIKit

class ZJShowBookCell: UITableViewCell {
    
    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var bookAuthorLabel: UILabel!
    
    var bookModel = Books(){
        didSet{
            //开始赋值
            bookImageView.sd_setImage(with: URL.init(string: bookModel.image!), placeholderImage: UIImage.init(named: ""))
            bookTitleLabel.text = bookModel.title
            
            bookAuthorLabel.text = String(format: "%@%@", (bookModel.author?.joined(separator: ","))!,bookModel.price!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
