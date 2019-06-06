//
//  RealmManager.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import RealmSwift

class RealmManager: NSObject {
    static let shared = RealmManager()
    let realm = try! Realm()
    
    func getComicRating(id_comic: Int) -> [String: Double] {
        guard let comic = realm.objects(ComicModel.self).filter("id_comic = \(id_comic)").first else { return ["count": 0, "rating_star": 0]}
        return ["count": Double(comic.ratings.count), "rating_star": (comic.rating_star)]
    }
}
