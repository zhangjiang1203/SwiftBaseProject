//
//Created by ESJsonFormatForMac on 17/08/04.
//

import UIKit

import HandyJSON

class ZJRequestTestModel: HandyJSON {

    var info: Info?

    var list: [List]?
    
    required init() {
        
    }

}

class Info: HandyJSON {

    var maxid: String?

    var vendor: String?

    var count: Int = 0

    var maxtime: String?

    var page: Int = 0
    
    required init() {
        
    }

}

class List: HandyJSON {
    //段子信息
    var cache_version: Int = 0

    var created_at: String?

    var ID: String?

    var voicetime: String?

    var voicelength: String?

    var top_cmt: [String]?

    var repost: String?

    var bimageuri: String?

    var text: String?

    var theme_type: String?

    var hate: String?

    var ding: String?

    var comment: String?

    var passtime: String?

    var type: String?

    var tag: String?

    var theme_name: String?

    var create_time: String?

    var favourite: String?

    var themes: [String]?

    var name: String?

    var height: String?

    var status: String?

    var videotime: String?

    var bookmark: String?

    var cai: String?

    var screen_name: String?

    var profile_image: String?

    var love: String?

    var user_id: String?

    var theme_id: String?

    var original_pid: String?

    var t: Int = 0

    var weixin_url: String?

    var voiceuri: String?

    var videouri: String?

    var width: String?
    
    //图片的另外的值
    var is_gif: String?
    
    var image2: String?
    
    var image1: String?
    
    var image0: String?
    
    var cdn_img: String?
    
    //视频
    var playfcount: String?
    
    var playcount: String?
    
    //声音
    var image_small: String?
    //图片的高度
    var imageHeight:CGFloat = 0
    //是否计算过了
    var isLoad:Bool = false
    //当前所在的下标
    var dataIndex:Int = 0
    
    
    //计算cell显示的高度
    var cellHeight:CGFloat{
        get{
            let tempStr = self.text! as NSString
            print("获取的高度=%@=",imageHeight)
            let textHeight = tempStr.getSuitSize(withFontSize: 15, bold: false, sizeOfX: Float(KScreenWidth-30))
            return textHeight + imageHeight + 130;
        }
    }
    required init() {
        
    }

}

