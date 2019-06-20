//
//  HomeTabbarViewController.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/19/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class HomeTabbarViewController: UITabBarController {
    var fvrComics = [InfoComicModel]()
    var recentComics = [InfoComicModel]()
    let home = HomeViewController()
    let home2 = HomeViewController2()
    let search = SearchViewController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        self.tabBarController?.tabBar.isTranslucent = false
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
        
        home2.tabBarItem = UITabBarItem(title: "2", image: UIImage(named: "homeIcon"), tag: 1)
        
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    func updateData() {
        var suggestComics = [InfoComicModel]()
        let group = DispatchGroup()
        var fvrIdArr = [Int]()
        for i in RealmManager.shared.user.favorites {
            fvrIdArr.append(i.id_comic)
        }
    
        let t1 = (5 < fvrIdArr.count ? 5 : fvrIdArr.count)
        let t2 = (5 < RealmManager.shared.user.recent.count ? 5 : RealmManager.shared.user.recent.count)
        
        
        for i in 0..<t1 {
            group.enter()
            ComicApiManage.shared.getComicById(id_comic: fvrIdArr[i]) { (success, data) in
                if success {
                    self.fvrComics.append(data as! InfoComicModel)
                    suggestComics.append(data as! InfoComicModel)
                    fvrIdArr.removeFirst()
                    group.leave()
                }
            }
        }
        for i in 0..<t2 {
            group.enter()
            ComicApiManage.shared.getComicById(id_comic: RealmManager.shared.user.recent[i].id_comic) { (success, data) in
                if success {
                    self.recentComics.append(data as! InfoComicModel)
                    suggestComics.append(data as! InfoComicModel)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
//            self.home.setSuggestData(data: suggestComics)
            self.home2.initData(fvrData: self.fvrComics, fvrIdArr: fvrIdArr)
            self.viewControllers = [self.home2, self.search]
        }
    }
    
}
