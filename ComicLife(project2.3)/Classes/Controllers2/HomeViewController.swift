//
//  HomeViewController2.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var newestComics = [HomeModel]()
    var popularComics = [HomeModel]()
    var tempComics = [HomeModel]()
    
    lazy var tableView :UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        HomeTBViewCell.registerCellByClass(tableView)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        tableView.tableHeaderView = UIView(frame: .zero)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
//        getData()
        testQueue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
        DispatchQueue.main.async {
            for i in 0..<3 {
                (self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? HomeTBViewCell)!.collectionView.reloadData()
            }
        }
    }
    
    func getData() {
       
//        ComicApiManage.shared.getHomeComics { (status, data) in
//            if status {
//                if let data = data {
//                    self.popularComics = data["popular"] as! [HomeModel]
//                    self.newestComics = data["newest"] as! [HomeModel]
//
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
        
        let group = DispatchGroup()
        group.enter()
        ComicApiManage.shared.getHomeComics(completion: { (success, data) in
            self.popularComics = data!["popular"] as! [HomeModel]
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            group.leave()
        })
        
        group.notify(queue: .main) {
            DispatchQueue.main.async {
                ComicApiManage.shared.getHomeComics(completion: { (success, data) in
                    self.tempComics = data!["popular"] as! [HomeModel]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
                ComicApiManage.shared.getHomeComics(completion: { (success, data) in
                    self.newestComics = data!["newest"] as! [HomeModel]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        }
        
    }
    
    var a = false
    var b = false
    var c = false
    
    func testQueue() {
        DispatchQueue.main.async {
        let group = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 1)
            ComicApiManage.shared.getHomeComics(completion: { (success, data) in
                self.popularComics = data!["popular"] as! [HomeModel]
                self.a = true
                semaphore.signal()
                print("A")
            })
//            group.enter()
            ComicApiManage.shared.getHomeComics(completion: { (success, data) in
                self.newestComics = data!["popular"] as! [HomeModel]
                self.b = true
               print("B")
            })
            
            semaphore.wait()
            semaphore.wait()
            
//            group.enter()
            ComicApiManage.shared.getHomeComics(completion: { (success, data) in
                self.tempComics = data!["popular"] as! [HomeModel]
                self.c = true
//                group.leave()
//                group.leave()
                print("C")
            })
            
            group.notify(queue: .main, execute: {
                print(self.a.description + self.b.description + self.c.description)
                print("success")
            })
        }
    }

    func initLayout() {
//        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
//        self.headerView.snp.makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.top.equalTo(self.view).offset(44)
//        }
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
    }
    
    func setNavigationBar() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM dd"
        let date = dateFormatter.string(from: Date())
        let lbl = NSMutableAttributedString(string: "\(date)\n", attributes: [NSAttributedString.Key.foregroundColor : GRAY_COLOR, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        let lbl2 = NSAttributedString(string: "Today", attributes: [ NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 22)])
        lbl.append(lbl2)
        
//        (self.tabBarController as! HomeTabbarViewController).titleNaviBarLbl.attributedText = lbl
    }
    
}

extension HomeViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = HomeTBViewCell.loadCell(self.tableView) as? HomeTBViewCell else { return BaseTBCell() }
        
        switch indexPath.item {
        case 0:
            cell.initData(imgHeight: COL_CELL_HEIGHT, title: "Top Read Comics", data: self.popularComics)
           
        case 1:
            cell.initData(imgHeight: COL_CELL_HEIGHT, title: "Newest Comics", data: self.newestComics)
        case 2:
            cell.initData(imgHeight: COL_CELL_HEIGHT, title: "Temp Comics", data: self.tempComics)
            
        default:
            break
        }
        cell.delegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
   
}

extension HomeViewController: HomeTBCellDelegate {
    func pushVCToComic(id_comic: Int) {
        let vc = ComicViewController()
        vc.initData(id_comic: id_comic)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushVCToAllComic(title: String, data: [HomeModel]) {
       
        let vc = LstComicViewController()
        vc.initData(title: title, data: data)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
