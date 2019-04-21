//
//  SimilarComicModel.swift
//  project2
//
//  Created by Macintosh on 4/9/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class SimilarComicModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var imgUrl: String = ""
    @objc dynamic var numIssues: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        self.title = json["title"].stringValue
        self.url = json["url"].stringValue
        self.imgUrl = json["cover"].stringValue
        self.numIssues = json["number_issues"].intValue
    }
}

