//
//  ViewController.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, SelectCellDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var popularComics: [ComicHomeModel] = [ComicHomeModel]()
    var newestComics: [ComicHomeModel] = [ComicHomeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableCell")
        
        getData()
    }
    
    func getData() {
        ComicApiManage.shared.getHomeComics { (status, data) in
            if status {
                if let data = data {
                    self.popularComics = data["popular"] as! [ComicHomeModel]
                    self.newestComics = data["newest"] as! [ComicHomeModel]
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
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
            
        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func pushVC(url: String) {
        let in4VC = In4ViewController()
        in4VC.urlComic = url
        self.navigationController?.pushViewController(in4VC, animated: true)
    }
}
