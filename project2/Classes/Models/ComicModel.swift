//
//  ComicModel.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import RealmSwift

class ComicModel: Object {
    @objc dynamic var id_comic = 0
    @objc dynamic var rating_star: Double = 0
    var favorites = List<Favorite>()
    var ratings = List<Rating>()
    var comments = List<Comment>()
    
    convenience init(id_comic : Int) {
        self.init()
        self.id_comic = id_comic
        setRatingStar()
    }
    override static func primaryKey() -> String? {
        return "id_comic"
    }
    
    func setRatingStar() {
        var totalStar: Double = 0
        var totalLvl:Double = 0
        for rating in self.ratings {
            let usr_lvl = Double(rating.user_level)
            totalStar += rating.rating_star*usr_lvl
            totalLvl += usr_lvl
        }
        self.rating_star = totalStar/totalLvl
    }
    
    func pushFavorite(id_usr: String) {
        let favorite = Favorite(id_user: id_usr, id_comic: self.id_comic)
        favorites.insert(favorite, at: 0)
    }
    
    func pushRating(id_usr: String, usr_lvl: Int, rating_star: Double) {
        let rating = Rating(id_user: id_usr, id_comic: self.id_comic, rating_star: rating_star , user_level: usr_lvl)
        ratings.insert(rating, at: 0)
    }
    
    func pushComment(id_usr: String, comment: String) {
        let comment = Comment(id_user: id_usr, id_comic: self.id_comic, comment: comment)
        comments.insert(comment, at: 0)
    }
}
