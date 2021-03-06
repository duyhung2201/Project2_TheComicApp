///Users/apple/Documents/Repository/Xcode/Swift/IOS_TheComicApp/project2.2/project2
//  InfoComicModel.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SwiftyJSON

func parseJsonToArr(att: String, json: JSON) -> [String] {
    let json = json[att]
    var arr = [String]()
    for i in json.arrayValue {
        arr.append(i.stringValue)
    }
    return arr
}

class InfoComicModel: NSObject {
    var author: String = ""
    var genre: String = ""
    var id = 0
    var title: String = ""
    var publisher: String = ""
    var year: String = ""
    var status: String = ""
    var summary: String = ""
    var image: String = ""
    var number_issues: Int = 0
    var issues = [Issues]()
    var similars = [HomeModel]()
    
    convenience init(json: JSON) {
        self.init()
        author = parseJsonToArr(att: "author", json: json).joined(separator: ", ")
        genre = parseJsonToArr(att: "genre", json: json).joined(separator: ", ")
        id = json["_id"].intValue
        image = json["cover"].stringValue
        number_issues = json["number_issues"].intValue
        publisher = json["publisher"].stringValue
        title = json["title"].stringValue
        status = json["status"].stringValue
        year = json["year"].stringValue
        summary = json["summary"].stringValue
        
        for i in json["issues"].arrayValue {
            let _issue = Issues(json: i)
            self.issues.append(_issue)
        }
        
        for i in 1..<json["similar"].count {
            let _similar = HomeModel()
            _similar.shortInit(json: json["similar"][i])
            self.similars.append(_similar)
        }
    }
}

class Issues: NSObject {
    var _id = ""
    var title = ""
    
    init(json: JSON){
        self._id = json["_id"].stringValue
        self.title = json["title"].stringValue
    }
}

class SimilarComic2: NSObject {
    var _id = ""
    var title = ""
    var cover = ""
    
    init(json: JSON){
        self._id = json["_id"].stringValue
        self.title = json["title"].stringValue
        self.cover = json["cover"].stringValue
    }
}
