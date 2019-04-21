//
//  SearchModel.swift
//  project2
//
//  Created by Macintosh on 3/26/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class SearchModel: Object {
    var url = [String]()
    var title = [String]()
    
    convenience init(json: JSON){
        self.init()
        for i in json.arrayValue {
            url.append(i["url"].stringValue)
            title.append(i["title"].stringValue)
        }
    }
}
