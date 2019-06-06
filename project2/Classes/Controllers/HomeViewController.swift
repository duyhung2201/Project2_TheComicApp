//
//  ViewController.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var popularComics: [HomeModel] = [HomeModel]()
    var newestComics: [HomeModel] = [HomeModel]()
    var favComics : [HomeModel] = [HomeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
//        self.title = "Home"
        getData()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        self.getFavData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    }
    
    func getData() {
        ComicApiManage.shared.getHomeComics { (status, data) in
            if status {
                if let data = data {
                    self.popularComics = data["popular"] as! [HomeModel]
                    self.newestComics = data["newest"] as! [HomeModel]
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func getFavData() {
        favComics = [HomeModel]()
        let realm = try!Realm()
        let favTable = realm.objects(FavoriteComicModel.self)
        
        for i in favTable{
            favComics.append(i.convertToHomeData())
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, SelectCellDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(COL_CELL_HEIGHT + 60)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
        cell.delegate = self
        switch(indexPath.row) {
        case 0:
            cell.titleLabel.text = "Popular"
            cell.data = popularComics
            
        case 1:
            cell.titleLabel.text = "Newest"
            cell.data = newestComics
        case 2:
            if(favComics.count == 0){
                cell.titleLabel.text = "Favorite: You haven't had any favorite Comics!"
            }else{
                cell.titleLabel.text = "Favorite"
                cell.data = favComics
            }
        default:
            break
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func pushVC(url: String) {
        let in4VC = InfoViewController()
        in4VC.urlComic = url
        self.tabBarController?.navigationController?.pushViewController(in4VC, animated: true)
 
    }
}
