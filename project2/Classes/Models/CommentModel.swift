//
//  CommentModel.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import RealmSwift

class Comment : Object {
    @objc dynamic var id_user = ""
    @objc dynamic var id_comic = 0
    @objc dynamic var comment = ""
    @objc dynamic var commented_at = Date.init(timeIntervalSinceNow: 0)
    
    convenience init(id_user: String, id_comic: Int, comment: String) {
        self.init()
        self.id_user = id_user
        self.id_comic = id_comic
        self.comment = comment
    }
}

