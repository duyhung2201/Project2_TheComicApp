////
////  ComicModel.swift
////  project2
////
////  Created by Macintosh on 6/5/19.
////  Copyright © 2019 HoaPQ. All rights reserved.
////
//
//import Foundation
//import RealmSwift
//
//class ComicModel: Object {
//    @objc dynamic var id_comic = 0
//    @objc dynamic var rating_star: Double = 0.0
//    var favorites = List<Favorite>()
//    var ratings = List<Rating>()
//    var reviews = List<Review>()
//    
//    convenience init(id_comic : Int) {
//        self.init()
//        self.id_comic = id_comic
//    }
//    override static func primaryKey() -> String? {
//        return "id_comic"
//    }
//    
//    func updateRatingPoint() {
//        var totalStar = 0
//        var totalLvl = 0
//        for rating in self.ratings {
//            let usr_lvl = rating.user_level
//            totalStar += rating.rating_point*usr_lvl
//            totalLvl += usr_lvl
//        }
//        rating_star = Double(totalStar)/Double(totalLvl)
//    }
//    
//    func addFavorite(favorite: Favorite) {
//        favorites.append(favorite)
//    }
//    
//    func removeFavorite(id_usr: String) {
//        for i in 0..<favorites.count {
//            if (favorites[i].id_user == id_usr) {
//                favorites.remove(at: i)
//            }
//        }
//    }
//    
//    func addRating(rating: Rating) {
//        ratings.append(rating)
//        updateRatingPoint()
//    }
//    
//    func addReview(review: Review) {
//        reviews.insert(review, at: 0)
//    }
//}
