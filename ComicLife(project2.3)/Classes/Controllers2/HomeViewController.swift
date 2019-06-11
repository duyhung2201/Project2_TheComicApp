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
    var suggestComics = [HomeModel]()
    var loadView = LoadView()
    
    lazy var headerView : HeaderView = {
        let headerView = HeaderView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM dd"
        let date = dateFormatter.string(from: Date())
        headerView.initData(imgHeight: 44, title: "Today", sub_title: date, imgUrl: RealmManager.shared.user.avatar)
        
        return headerView
    }()
    
    lazy var tableView :UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        HomeTBViewCell.registerCellByClass(tableView)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        self.view.addSubview(loadView)
        getData()
        getSuggestData(idArr: RealmManager.shared.user.getComicsToSuggest())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        DispatchQueue.main.async {
            for i in 0..<3 {
                (self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? HomeTBViewCell)!.collectionView.reloadData()
            }
        }
    }
    
    func getSuggestData(idArr : [Int]){
        let group = DispatchGroup()
        
        for id in idArr {
            group.enter()
            ComicApiManage.shared.getComicById(id_comic: id) { (success, data) in
                if success {
                    for i in 0..<3{
                        self.suggestComics.append((data as! InfoComicModel).similars[i])
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            DispatchQueue.main.async {
                    self.tableView.reloadData()
            }
            
            self.loadView.removeFromSuperview()
        }
    }
    
    func getData() {
        //popular & newest
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

    func initLayout() {
        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        self.headerView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(self.view).offset(44)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(0)
        }
        
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
             cell.initData(imgHeight: COL_CELL_HEIGHT, title: "Suggest for You", data: self.suggestComics)
            cell.separatorInset = UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0)
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
