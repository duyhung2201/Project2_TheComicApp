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
    var user : User?
    
    func setUser(usr_id: String) {
        
        guard let user = realm.objects(User.self).filter("id = '\(usr_id)'").first else {
            let user = User(id: usr_id, password: "123456")
            try! realm.write {
                realm.add(user)
            }
            self.user = user
            return  }
        self.user = user
    }
    
    func printRealmUrl() {
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func setDefaultRealmForUser(path: String) {
        let config = Realm.Configuration(fileURL: URL(string: path))
        Realm.Configuration.defaultConfiguration = config
        print(Realm.Configuration.defaultConfiguration.fileURL)
    }
    
    func logout() {
        self.user = User()
        UserDefaults.standard.removeObject(forKey: USER_KEY)
    }
    
    func addComment(id_comic: Int, comment: String){
        let commentModel = Comment(id_user: (user?.id)!, id_comic: id_comic, comment: comment)
        try! realm.write {
            self.user?.addComment(comment: commentModel)
//            realm.add(commentModel)
            guard let comic = realm.objects(ComicModel.self).filter("id_comic == \(id_comic)").first else {
                let comic = ComicModel(id_comic: id_comic)
                comic.addComment(comment: commentModel)
                realm.add(comic)
                return
            }
            comic.addComment(comment: commentModel)
        }
    }
    
    func isFavorited(id_comic: Int) -> Bool {
        for favorite in (self.user?.favorites)! {
            if( favorite.id_comic == id_comic){
                return true
            }
        }
        return false
    }
    
    func getRealmComicData(id_comic: Int) -> [String : Any] {
        guard let comic = realm.objects(ComicModel.self).filter("id_comic == \(id_comic)").first else {
            return [RealmComicTypeData.fvrState.rawValue : false,
                    RealmComicTypeData.fvrCount.rawValue : 0,
                    RealmComicTypeData.ratingCount.rawValue : 0,
                    RealmComicTypeData.ratingPoint.rawValue : 0.0,
                    RealmComicTypeData.ratings.rawValue : List<Rating>(),
                    RealmComicTypeData.comments.rawValue : List<Comment>()]
        }
        return [RealmComicTypeData.fvrState.rawValue : isFavorited(id_comic: id_comic),
                RealmComicTypeData.fvrCount.rawValue : comic.favorites.count,
                RealmComicTypeData.cmtCount.rawValue : comic.comments.count,
                RealmComicTypeData.ratingCount.rawValue : comic.ratings.count,
                RealmComicTypeData.ratingPoint.rawValue : comic.rating_star,
                RealmComicTypeData.ratings.rawValue : comic.ratings,
                RealmComicTypeData.comments.rawValue : comic.comments]
    }
    
    func updateFavortie(id_comic: Int){
        
        try! realm.write {
            if isFavorited(id_comic: id_comic) {
                guard let favorite = realm.objects(Favorite.self).filter("id_comic == \(id_comic) AND id_user = '\((self.user?.id)!)'").first else {return}
                realm.delete(favorite)
                
            } else {
                let favorite = Favorite(id_user: (self.user?.id)!, id_comic: id_comic)
                self.user?.addFavorite(favorite: favorite)
                guard let  comic = realm.objects(ComicModel.self).filter("id_comic == \(id_comic)").first else {
                    let comic = ComicModel(id_comic: id_comic)
                    comic.addFavorite(favorite: favorite)
                    realm.add(comic)
                    return
                }
                comic.addFavorite(favorite: favorite)
            }
        }
    }
    
    
    func addRating(id_comic: Int, rating_point: Double){
        let rating = Rating(id_user: (self.user?.id)!, id_comic: id_comic, rating_point: rating_point, user_level: (self.user?.level)!)
        try! realm.write {
            // rated
            for i in 0..<(user?.ratings)!.count {
                if (user?.ratings[i].id_comic == id_comic){
                    user?.ratings[i].rating_star = rating.rating_star
                    user?.ratings[i].rated_at = rating.rated_at
                    return
                }
            }
            
            //un-rated
            self.user?.addRating(rating: rating)
            guard let  comic = realm.objects(ComicModel.self).filter("id_comic == \(id_comic)").first else {
                let comic = ComicModel(id_comic: id_comic)
                comic.addRating(rating: rating)
                realm.add(comic)
                return  }
            comic.addRating(rating: rating)
        }
    }
    
}
