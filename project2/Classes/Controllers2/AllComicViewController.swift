//
//  AllCateViewController.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SnapKit.Swift

class AllComicViewController: UIViewController {
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
        AllComicTBViewCell.registerCellByClass(tableView)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func initLayout() {
        self.view.addSubview(tableView)
    }
    
    func setLayoutTBView() {
        self.tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
}

extension AllComicViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = AllComicTBViewCell.loadCell(tableView) as? AllComicTBViewCell else { return BaseTBCell() }
        cell.data = data[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }

}
