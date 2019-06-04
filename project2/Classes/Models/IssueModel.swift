//
//  IssueModel.swift
//  project2
//
//  Created by Macintosh on 3/19/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class IssueModel: Object {
    @objc dynamic var _id: String = ""
    @objc dynamic var title: String = ""
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

