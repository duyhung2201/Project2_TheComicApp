//
//  HomeViewController2.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class HomeViewController2: UIViewController {
    var favoriteData = [InfoComicModel]()
    var fvrIdArr = [Int]()
    var recentData = [InfoComicModel]()
    var recentIdArr = [Int]()
    
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
        UsrComicTBViewCell.registerCellByClass(tableView)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            for i in 0..<1 {
                (self.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? UsrComicTBViewCell)!.collectionView.reloadData()
            }
        }
    }
    
    func initData(fvrData: [InfoComicModel], fvrIdArr: [Int], recentData: [InfoComicModel], recentIdArr: [Int]) {
        self.favoriteData = fvrData
        self.fvrIdArr = fvrIdArr
        self.recentData = recentData
        self.recentIdArr = recentIdArr
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

extension HomeViewController2 : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = UsrComicTBViewCell.loadCell(self.tableView) as? UsrComicTBViewCell else { return BaseTBCell() }
        
        switch indexPath.item {
        case 0:
            cell.initData(imgHeight: COL_CELL_HEIGHT, title: "Favorite", data: self.favoriteData, idArr: self.fvrIdArr)

        case 1:
            cell.initData(imgHeight: COL_CELL_HEIGHT, title: "Recently", data: self.recentData, idArr: self.recentIdArr)
            cell.separatorInset = UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0)
            
        default:
            break
        }
        cell.delegate = self
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}

extension HomeViewController2: UsrComicTBViewCellDelegate{
    func pushVCToComic(data: InfoComicModel) {
        let vc = ComicViewController()
        vc.initData2(data: data, id_comic: data.id)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushVCToLstComic(title: String, data: [InfoComicModel]) {
        
        let vc = LstComicViewController2()
        vc.initData(title: title, data: data)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

