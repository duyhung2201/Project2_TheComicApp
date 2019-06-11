//
//  SearchModel.swift
//  project2
//
//  Created by Macintosh on 3/26/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//
 
import Foundation
import SwiftyJSON

//{
//    "author": [
//    "Matt Brady",
//    "Jack Jaoson"
//    ],
//    "genre": [
//    "action",
//    "adventure",
//    "fantasy",
//    "sci-fi"
//    ],
//    "_id": 1404,
//    "created_at": "2019-02-27T11:39:48.228Z",
//    "updated_at": "2019-02-27T11:39:48.228Z",
//    "title": "Warlord Of Mars",
//    "url": "/warlord-of-mars",
//    "publisher": "Dynamite Entertainment",
//    "alternatives": "N/A.",
//    "year": 2010,
//    "status": "completed",
//    "summary": "If everything he loves is taken away from him, who is John Carter? Will the Warlord of Mars lose hope if he loses his friends, if he loses Dejah Thoris? If he loses Mars? Or will he fight all odds and even reality itself to get it all back?",
//    "cover": "https://comicpunch.net/pics/chngkng-14-000.jpg",
//    "number_issues": 38,
//    "score": 0.75,
//    "id": "1404"
//},

class SearchModel: NSObject {
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
    var score: Double = 0
    
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
        score = json["scrore"].doubleValue
    }
}
