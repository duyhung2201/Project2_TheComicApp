//
//  CommentModel.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import RealmSwift

class Review : Object {
    @objc dynamic var id_user = ""
    @objc dynamic var usr_name = ""
    @objc dynamic var id_comic = 0
    @objc dynamic var reviewContent = ""
    @objc dynamic var ratingPoint = 0
    @objc dynamic var reviewed_at = Date()
    
    convenience init(id_user: String, id_comic: Int, ratingPoint: Int, reviewContent: String, usr_name: String = "") {
        self.init()
        self.id_user = id_user
        if usr_name.isEmpty{
            self.usr_name = RealmManager.shared.getUsrname(id_usr: id_user)
        }else {
            self.usr_name = usr_name
        }
        self.id_comic = id_comic
        self.reviewContent =  reviewContent
        self.ratingPoint = ratingPoint
    }
}

