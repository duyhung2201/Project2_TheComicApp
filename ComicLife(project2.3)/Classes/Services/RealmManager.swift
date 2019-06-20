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
    var user = User()
    
    func setUser(id_usr: String) -> Bool {
        guard let user = realm.objects(User.self).filter("id = '\(id_usr)'").first else {
//            let user = User(id: id_usr, password: "123456")
//            try! realm.write {
//                realm.add(user)
//            }
//            self.user = user
            return false
        }
        self.user = user
        return true
    }
    
    
    func printRealmUrl() {
        print(Realm.Configuration.defaultConfiguration.fileURL as! URL)
    }
    
    func setDefaultRealmPath(path: String) {
        var config = Realm.Configuration()
        
        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(path).realm")
        
        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
    
    func logout() {
        self.user = User()
        UserDefaults.standard.removeObject(forKey: USER_KEY)
    }
    
    func getUsrname(id_usr: String) -> String {
        guard let usr_name = realm.objects(User.self).filter("id == '\(id_usr)'").first?.nick_name else { return "Anynomos User" }
        
        return usr_name
    }
    
    func test() {
        
    }
    
    func addRecent(id_comic: Int){
        try! realm.write {
            self.user.addRecent(id_comic: id_comic)
        }
    }
    
    
    func addReview(id_comic: Int, comment: String, ratingPoint: Int){
        let review = Review(id_user: (user.id), id_comic: id_comic, ratingPoint: ratingPoint, reviewContent: comment)
        try! realm.write {
            self.user.addReview(review: review)
        }
    }
    
    func isFavorited(id_comic: Int) -> Bool {
        guard (self.user.favorites.filter("id_comic == \(id_comic)").first) != nil else { return false }
        return true
    }
    
    func getRealmComicData(id_comic: Int) -> [String : Any] {
//        guard let comic = realm.objects(ComicModel.self).filter("id_comic == \(id_comic)").first else {
//            return [RealmComicTypeData.fvrState.rawValue : false,
//                    RealmComicTypeData.fvrCount.rawValue : 0,
//                    RealmComicTypeData.ratingCount.rawValue : 0,
//                    RealmComicTypeData.ratingPoint.rawValue : 0.0,
//                    RealmComicTypeData.reviews.rawValue : List<Review>()]
//        }
        
        return [RealmComicTypeData.fvrState.rawValue : isFavorited(id_comic: id_comic),
                RealmComicTypeData.fvrCount.rawValue : Int.random(in: 0...1000),
                RealmComicTypeData.reviewCount.rawValue : Int.random(in: 0...1000),
                RealmComicTypeData.ratingCount.rawValue : Int.random(in: 0...1000),
                RealmComicTypeData.ratingPoint.rawValue : round(Double.random(in: 1...5)*10)/10,
                RealmComicTypeData.reviews.rawValue : user.reviews]
        
    }
    
    func updateFavortie(id_comic: Int){
        try! realm.write {
            guard let favorite = self.user.favorites.filter("id_comic == \(id_comic)").first else {
                let favorite = Favorite(id_user: (self.user.id), id_comic: id_comic)
                self.user.addFavorite(favorite: favorite)
//                guard let  comic = realm.objects(ComicModel.self).filter("id_comic == \(id_comic)").first else {
//                    let comic = ComicModel(id_comic: id_comic)
//                    comic.addFavorite(favorite: favorite)
//                    realm.add(comic)
//                    return
//                }
//                comic.addFavorite(favorite: favorite)
                
                return
            }
            realm.delete(favorite)
        }
    }
    
    
    func addRating(id_comic: Int, rating_point: Int){
        let rating = Rating(id_user: (self.user.id), id_comic: id_comic, rating_point: rating_point, user_level: (self.user.level))
        
        try! realm.write {
//            guard let comic = realm.objects(ComicModel.self).filter("id_comic == \(id_comic)").first else {
//                //comic is not exist in realm db
//                let comic = ComicModel(id_comic: id_comic)
//                comic.addRating(rating: rating)
//                realm.add(comic)
//                self.user.addRating(rating: rating)
//                return
//            }
            //comic is exist in realm db
            //check if user rated
            guard let usrRating = self.user.ratings.filter("id_comic == \(id_comic)").first else {
                //user un-rated
                self.user.addRating(rating: rating)
//                comic.addRating(rating: rating)
                
                return
            }
            usrRating.rating_point = rating.rating_point
            usrRating.rated_at = rating.rated_at
//            comic.updateRatingPoint()
        }
    }
    
}
