//
//  swift
//  project2
//
//  Created by Macintosh on 3/15/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class IssueComic: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var id: String = ""
    
    convenience init(json: JSON) {
        self.init()
        title = json["title"].stringValue
        id = json["_id"].stringValue
    }
}

class InfoComicModel: Object {
    @objc dynamic var author: String = ""
    @objc dynamic var genre: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var publisher: String = ""
    @objc dynamic var year: String = ""
    @objc dynamic var status: String = ""
    @objc dynamic var summary: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var number_issues: Int = 0
    @objc dynamic var url: String = ""
    var issues = [IssueComic]()
    
    convenience init(json: JSON) {
        self.init()
        author = parseJsonToArr(att: "author", json: json).joined(separator: ", ")
        genre = parseJsonToArr(att: "genre", json: json).joined(separator: ", ")
        id = json["_id"].stringValue
        image = json["cover"].stringValue
        number_issues = json["number_issues"].intValue
        publisher = json["publisher"].stringValue
        title = json["title"].stringValue
        status = json["status"].stringValue
        year = json["year"].stringValue
        summary = json["summary"].stringValue
        url = json["url"].stringValue
        
        for i in json["issues"].arrayValue {
            let _issue = IssueComic.init(json: i)
            self.issues.append(_issue)
        }
    }

    func parseJsonToArr(att: String, json: JSON) -> [String] {
        let json = json[att]
        var arr = [String]()
        for i in json.arrayValue {
            arr.append(i.stringValue)
        }
        return arr
    }
}


