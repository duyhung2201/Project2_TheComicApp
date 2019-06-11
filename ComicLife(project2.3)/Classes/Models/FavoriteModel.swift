//
//  FavoriteModel.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import RealmSwift

class Favorite : Object {
    @objc dynamic var id_user = ""
    @objc dynamic var id_comic = 0
    @objc dynamic var favorited_at = Date()
    
    convenience init(id_user: String, id_comic: Int) {
        self.init()
        self.id_user = id_user
        self.id_comic = id_comic
    }
}
