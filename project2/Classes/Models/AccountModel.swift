//
//  Accout.swift
//  project2
//
//  Created by Macintosh on 5/27/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {
    @objc dynamic var id = ""
    @objc dynamic var password = ""
    
    convenience init(id: String, password: String) {
        self.init()
        self.id = id
        self.password = password
    }
    override static func primaryKey() -> String? {
        return "id"
    }
}
//    let DB : [String : Any] = [
//        
//        "comic" : [
//            "_id" : Int32(),
//            "created_at" : Date(),
//            "updated_at" : Date(),
//            "title" : String(),
//            "url" : String(),
//            "publisher" : String(),
//            "alternatives" : String(),
//            "author" : Array<String>(),
//            "genre" : Array<String>(),
//            "year" : Int32(),
//            "status" : String(),
//            "summary" : String(),
//            "cover" : String(),
//            "number_issues" : Int32()
//        ],
//        
//        "issues" : [
//            "_id" : Object(),
//            "comic_id" : Int32(),
//            "created_at" : Date(),
//            "is_crawled" : Bool(),
//            "num_issue" : Int32(),
//            "title" : String(),
//            "url" : String(),
//            "img" : Array<String>()
//        ],
//        
//        "users" : [
//            "_id" : Object(),
//            "username" : String(),
//            "password" : String(),
//            "_v" : Int32()
//        ]
//    ]



