//
//Created by ESJsonFormatForMac on 17/08/24.
//

import UIKit
import HandyJSON


class ZJCarDetailModel: HandyJSON {

    var msg: String?

    var result: [Result]?

    var retCode: String?
    
    required init() {
        
    }

}

class Result: HandyJSON {

    var seriesName: String?

    var wheelInfo: [CarNameValue]?

    var sonBrand: String?

    var mediaConfig: [CarNameValue]?

    var chassis: [CarNameValue]?

    var controlConfig: [CarNameValue]?

    var brand: String?

    var carImage: String?

    var transmission: [CarNameValue]?

    var techConfig: [CarNameValue]?

    var baseInfo: [CarNameValue]?

    var brandName: String?

    var glassConfig: [CarNameValue]?

    var engine: [CarNameValue]?

    var airConfig: [CarNameValue]?

    var carbody: [CarNameValue]?

    var interConfig: [CarNameValue]?

    var exterConfig: [CarNameValue]?

    var safetyDevice: [CarNameValue]?

    var seatConfig: [CarNameValue]?

    var lightConfig: [CarNameValue]?
    
    required init() {
        
    }

}

class CarNameValue: HandyJSON {

    var name: String?

    var value: String?
    
    required init() {
        
    }
}

class CarProperty: HandyJSON {
    
    var key:String?
    
    var value:[CarNameValue]?
    
    required init() {
        
    }
}


