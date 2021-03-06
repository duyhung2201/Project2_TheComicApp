//
//  RatingModel.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import RealmSwift 

class Rating : Object {
    @objc dynamic var id_user = ""
    @objc dynamic var user_level = 0
    @objc dynamic var id_comic = 0
    @objc dynamic var rating_point = 0
    @objc dynamic var rated_at = Date()
    
    convenience init(id_user: String, id_comic: Int, rating_point: Int, user_level: Int) {
        self.init()
        self.id_user = id_user
        self.id_comic = id_comic
        self.rating_point = rating_point
        self.user_level = user_level
    }
}
