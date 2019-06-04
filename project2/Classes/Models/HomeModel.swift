//
//  HomeComicModel.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class ComicHomeModel: Object {
    
//    {
//    "img" : "https:\/\/readcomicsonline.me\/pics2\/xpqx001.jpg",
//    "title" : "Spawn",
//    "issue_name" : "Issue # 294",
//    "url" : "\/spawn",
//    "issue_url" : "https:\/\/readcomicsonline.me\/reader\/Spawn\/Spawn_Issue_294"
//    },
    
    @objc dynamic var imgUrl: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var issueName: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var issueUrl: String = ""
    
    convenience init(json: JSON) {
        self.init()
        imgUrl = json["img"].stringValue
        title = json["title"].stringValue
        issueName = json["issue_name"].stringValue
        url = json["url"].stringValue
        issueUrl = json["issue_url"].stringValue
    }
    
}
