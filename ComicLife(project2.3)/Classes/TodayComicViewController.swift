//
//  TodayComicViewController.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/11/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class TodayComicViewController: UIViewController {
    var data = [HomeModel]()
    
    lazy var headerView : HeaderView = {
        let headerView = HeaderView()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM dd"
        let date = dateFormatter.string(from: Date())
        headerView.initData(imgHeight: 44, title: "Today", sub_title: date, imgUrl: RealmManager.shared.user.avatar)
        
        return headerView
    }()
    
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
        tableView.tableFooterView = UIView(frame: .zero)
        TodayComicTBViewCell.registerCellByClass(tableView)
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        
        getData()
        initLayout()
    }
    
    func getData() {
        ComicApiManage.shared.getHomeComics { (status, data) in
            if status {
                if let data = data {
                    self.data = data["newest"] as! [HomeModel]
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func initLayout() {
//        self.headerView.snp.makeConstraints { (make) in
//            make.left.equalTo(0)
//            make.right.equalTo(0)
//            make.top.equalTo(0)
//        }
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
}

extension TodayComicViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = TodayComicTBViewCell.loadCell(tableView) as? TodayComicTBViewCell else { return BaseTBCell() }
        cell.initData(imgHeight: COL_CELL_HEIGHT, data: self.data[indexPath.row])
        
        if(indexPath.row == data.count){
            cell.separatorInset = UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ComicViewController()
        vc.initData(id_comic: data[indexPath.row].id)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
