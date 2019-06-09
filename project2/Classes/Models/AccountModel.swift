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
    @objc dynamic var level:Int = 1
    @objc dynamic var avatarName = "avatar720x720"
    var recent = List<Int>()
    var favorites = List<Favorite>()
    var ratings = List<Rating>()
    var comments = List<Comment>()
    
    convenience init(id: String, password: String) {
        self.init()
        self.id = id
        self.password = password
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func changeAvatar(name :String) {
        self.avatarName = name
    }
    
    func pushRecent(id_comic: Int) {
        self.recent.insert(id_comic, at: 0)
    }
    
    func addFavorite(favorite: Favorite) {
        favorites.append(favorite)
    }
    func removeFavorite(id_comic: Int) {
        for i in 0..<favorites.count {
            if (favorites[i].id_comic == id_comic) {
                favorites.remove(at: i)
            }
        }
    }
    
    func addRating(rating: Rating) {
        ratings.append(rating)
    }
    
    func addComment(comment: Comment) {
        comments.insert(comment, at: 0)
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



