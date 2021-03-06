//
//  HomeComicModel.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import SwiftyJSON

class HomeModel: NSObject {
    
//    title": "Bloodshot: Rising Spirit",
//    "url": "/bloodshot-rising-spirit",
//    "img": "https://comicpunch.net/pics4/shynar04.jpg",
//    "issue_url": "https://comicpunch.net/reader/Bloodshot-Rising-Spirit/Bloodshot-Rising-Spirit-(2018)-Issue-7",
//    "issue_name": "Issue # 7",
//    "id": 5465
//},
//    "_id": 5392,
//    "title": "Marvel Zombie (2018)",
//    "cover": "https://comicpunch.net/pics4/bork07.jpg"
    
    var imgUrl: String = ""
    var title: String = ""
    var issueName: String = ""
    var url: String = ""
    var issueUrl: String = ""
    var id :Int = 0
    
    convenience init(json: JSON) {
        self.init()
        imgUrl = json["img"].stringValue
        title = json["title"].stringValue
        issueName = json["issue_name"].stringValue
        url = json["url"].stringValue
        issueUrl = json["issue_url"].stringValue
        id = json["id"].intValue
    }
    
    func shortInit(json: JSON){
        self.imgUrl = json["cover"].stringValue
        self.id = json["_id"].intValue
        self.title = json["title"].stringValue
    }
    
}
