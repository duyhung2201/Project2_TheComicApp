//
//  HomeTabbarViewController.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/19/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class HomeTabbarViewController: UITabBarController {
    let home = HomeViewController()
    let home2 = HomeViewController2()
    let search = SearchViewController()
    var suggestIdArr = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        self.tabBar.isTranslucent = false
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
        
        home2.tabBarItem = UITabBarItem(title: "2", image: UIImage(named: "homeIcon"), tag: 1)
        
        search.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 3)
        
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func updateData() {
        var fvrComics = [InfoComicModel]()
        var recentComics = [InfoComicModel]()
        var suggestComics = [InfoComicModel]()
        let group = DispatchGroup()
        
        var fvrIdArr = [Int]()
        for i in RealmManager.shared.user.favorites {
            fvrIdArr.append(i.id_comic)
        }
        var recentIdArr = [Int]()
        for i in RealmManager.shared.user.recent {
            recentIdArr.append(i.id_comic)
        }
        
        var suggestFvrIdArr = [Int]()
        var suggestRecentIdArr = [Int]()
        
        let t1 = (5 < fvrIdArr.count ? 5 : fvrIdArr.count)
        for i in 0..<t1 {
            suggestFvrIdArr.append(fvrIdArr[i])
        }
        
        let t2 = (5 < recentIdArr.count ? 5 : recentIdArr.count)
        for i in 0..<t2 {
            suggestRecentIdArr.append(recentIdArr[i])
        }
        
        suggestIdArr = suggestFvrIdArr
        suggestIdArr.append(contentsOf: suggestRecentIdArr)
        suggestIdArr = Array(Set(suggestIdArr))
        
        for i in suggestIdArr {
            group.enter()
            ComicApiManage.shared.getComicById(id_comic: i) { (success, data) in
                if success {
                    suggestComics.append(data as! InfoComicModel)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            for id in suggestFvrIdArr {
                fvrComics.append(suggestComics[self.findIndex(id_comic: id)!])
                fvrIdArr.removeFirst()
            }
            for id in suggestRecentIdArr {
                recentComics.append(suggestComics[self.findIndex(id_comic: id)!])
                recentIdArr.removeFirst()
            }
            
            self.home2.initData(fvrData: fvrComics, fvrIdArr: fvrIdArr, recentData: recentComics, recentIdArr: recentIdArr)
            
            self.viewControllers = [self.home, self.home2, self.search]
        }
    }
    
    func findIndex(id_comic : Int) -> Int?{
        for i in 0..<suggestIdArr.count {
            if suggestIdArr[i] == id_comic{
                return i
            }
        }
        return nil
    }
    
    lazy var avatar : UIImageView = {
        let avatar = UIImageView(image: UIImage(named: RealmManager.shared.user.avatar))
        avatar.snp.makeConstraints { (make) in
            make.width.height.equalTo(44)
        }
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = 22
        avatar.contentMode = .scaleToFill
        
        return avatar
    }()
    
    lazy var titleNaviBarLbl: UILabel = {
        let titleNaviBarLbl = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        titleNaviBarLbl.text = "Test"
        
        titleNaviBarLbl.numberOfLines = 0
        
        return titleNaviBarLbl
    }()
    
    func setNavigationBar() {
        self.navigationItem.hidesBackButton = true
        
        let rightBarBtn = UIBarButtonItem()
        rightBarBtn.customView = avatar
        
        let leftBarBtn = UIBarButtonItem()
        leftBarBtn.customView = titleNaviBarLbl
        
        self.navigationItem.setLeftBarButton(leftBarBtn, animated: true)
        self.navigationItem.setRightBarButton(rightBarBtn, animated: true)
    }
}
