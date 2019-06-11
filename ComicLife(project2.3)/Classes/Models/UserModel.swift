//
//  Accout.swift
//  project2
//
//  Created by Macintosh on 5/27/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import RealmSwift

class RecentComic: Object {
    @objc dynamic var id_comic = 0
    @objc dynamic var date = Date()
    
    convenience init(id_comic: Int){
        self.init()
        self.id_comic = id_comic
    }
}

class User: Object {
    @objc dynamic var id = ""
    @objc dynamic var password = ""
    @objc dynamic var nick_name = ""
    @objc dynamic var level:Int = 1
    @objc dynamic var avatar = "avatar720x720"
    var recent = List<RecentComic>()
    var favorites = List<Favorite>()
    var ratings = List<Rating>()
    var reviews = List<Review>()
    
    convenience init(id: String, password: String, nick_name: String = "Anonymos User", level: Int = 1) {
        self.init()
        self.id = id
        self.password = password
        self.nick_name = nick_name
        self.level = level
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func changeAvatar(avatar :String) {
        self.avatar = avatar
    }
    
    func addFavorite(favorite: Favorite) {
        favorites.insert(favorite, at: 0)
    }
    
    func addReview(review: Review){
        self.reviews.append(review)
    }
    func addRating(rating: Rating){
        self.ratings.append(rating)
    }
    
    func addRecent(id_comic: Int){
        guard let recentComic = self.recent.filter("id_comic == \(id_comic)").first else {
            self.recent.insert(RecentComic(id_comic: id_comic), at: 0)
            return
        }
        recentComic.date = Date()
        self.recent.sort { $0.date.compare($1.date) == ComparisonResult.orderedDescending}
        
    }
    
    func isInRecently(id_comic: Int) -> Bool{
        guard (self.recent.filter("id_comic == \(id_comic)").first != nil) else {
            return false
        }
        return true
    }
    
    func getComicsToSuggest() -> [Int] {
        var idArr = [Int]()
        
        for i in 0..<(favorites.count < 5 ? favorites.count : 5){
           idArr.append(favorites[i].id_comic)

        }
        for i in 0..<(recent.count < 5 ? recent.count : 5){
            idArr.append(recent[i].id_comic)
        }
        
        idArr = Array(Set(idArr))
        return idArr
    }
    
    func getIdRecent() -> [Int] {
        var idArr = [Int]()
        
        for i in self.recent{
            idArr.append(i.id_comic)
        }
        return idArr
    }
    
    func getIdFvr() -> [Int] {
        var idArr = [Int]()
        
        for i in self.favorites{
            idArr.append(i.id_comic)
        }
        return idArr
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



