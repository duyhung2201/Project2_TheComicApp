//
//  AllCateViewController.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class LstComicTBViewController: UIViewController {
    var _title : String? {
        didSet {
            self.title = _title
        }
    }
    
    var data = [HomeModel](){ 
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN, bottom: 0, right: MARGIN)
        ImgComicTBViewCell.registerCellByClass(tableView)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    func initData(title: String, data: [HomeModel]){
        self._title = title
        self.data = data
    }
    
    func initLayout() {
        self.view.addSubview(tableView)
        setLayoutTBView()
    }
    
    func setLayoutTBView() {
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(-MARGIN)
        }
    }
}

extension LstComicTBViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = ImgComicTBViewCell.loadCell(tableView) as? ImgComicTBViewCell else { return BaseTBCell() }
        let data = self.data[indexPath.row]
        cell.initData(imgHeight: 141, id_comic: data.id, imgUrl: data.imgUrl, title: data.title, sub_title: "")
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

}
