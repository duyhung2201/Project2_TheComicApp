//
//  IssueModel.swift
//  project2
//
//  Created by Macintosh on 3/19/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class IssueModel: NSObject {
    var _id: String = ""
    var title: String = ""
    var img = [String]()
    
    convenience init(json: JSON){
        self.init()
        _id = json["_id"].stringValue
        title = json["title"].stringValue
        for i in json["img"].arrayValue {
            img.append(i.stringValue)
        }
    }
}

