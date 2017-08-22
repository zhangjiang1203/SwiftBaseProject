//
//Created by ESJsonFormatForMac on 17/08/22.
//

import UIKit
import HandyJSON


class ZJBookModel: HandyJSON {

    var count: Int = 0

    var books: [Books]?

    var total: Int = 0

    var start: Int = 0
    
    required init() {
        
    }

}

class Books: HandyJSON {

    var isbn13: String?

    var binding: String?

    var publisher: String?

    var pages: String?

    var title: String?

    var tags: [String]?

    var image: String?

    var catalog: String?

    var alt: String?

    var isbn10: String?

    var url: String?

    var alt_title: String?

    var images: Images?

    var summary: String?

    var pubdate: String?

    var origin_title: String?

    var ID: String?

    var subtitle: String?

    var translator: [String]?

    var price: String?

    var rating: Rating?

    var author: [String]?

    var author_intro: String?
    
    required init() {
        
    }

}

class Images: HandyJSON {

    var small: String?

    var large: String?

    var medium: String?
    
    required init() {
        
    }

}

class Rating: HandyJSON {

    var min: Int = 0

    var average: String?

    var max: Int = 0

    var numRaters: Int = 0
    
    required init() {
        
    }

}

