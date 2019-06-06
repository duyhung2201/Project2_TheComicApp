
//
//  FavoriteComicModel.swift
//  project2
//
//  Created by Macintosh on 4/9/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import Foundation
import RealmSwift

class FavoriteComicModel: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var imgUrl: String = ""
    @objc dynamic var numIssues: Int = 0
    
    convenience init(infoComicModel: InfoComicModel){
        self.init()
        title = infoComicModel.title
        url = infoComicModel.url
        imgUrl = infoComicModel.image
        numIssues = infoComicModel.number_issues
    }
    
    func convertToHomeData() -> HomeModel{
        let homeData = HomeModel();
        homeData.imgUrl = self.imgUrl
        homeData.title = self.title
        homeData.issueName = "Issue # \(self.numIssues)"
        homeData.url = self.url
        return  homeData
    }
}

