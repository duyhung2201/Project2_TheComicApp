//
//  HomeViewController2.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class HomeViewController2: UIViewController {
    var newestComics = [HomeModel]()
    var popularComics = [HomeModel]()

    lazy var tableView :UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        HomeTBViewCell.registerCellByClass(tableView)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN, bottom: 0, right: MARGIN)
        tableView.tableFooterView = UIView(frame: .zero)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        getData()
        
    }
    
    func initLayout() {
        self.view.addSubview(tableView)
        setTableViewLayout()
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
    
    func setTableViewLayout() {
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(100)
            make.bottom.equalTo(self.view)
        }
    }

}

extension HomeViewController2 : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = HomeTBViewCell.loadCell(self.tableView) as? HomeTBViewCell else { return BaseTBCell() }
        
        switch indexPath.item {
        case 0:
            cell.initData(imgHeight: COL_CELL_HEIGHT, title: "Newest Comics", data: self.newestComics)

        case 1:
            cell.initData(imgHeight: COL_CELL_HEIGHT, title: "Top Read Comics", data: self.popularComics)

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

extension HomeViewController2: BaseTBViewCellDelegate {
    func pushVCToComic(id_comic: Int) {
        let vc = ComicViewController()
        vc.initData(id_comic: id_comic)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushVCToAllComic(title: String, data: [HomeModel]) {
       
        let vc = LstComicTBViewController()
        vc.initData(title: title, data: data)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
