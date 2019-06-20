//
//  AllCateViewController.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SnapKit

class LstComicViewController2: UIViewController {
    var data = [InfoComicModel](){
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
        tableView.tableFooterView = UIView(frame: .zero)
        LstComicTBViewCell.registerCellByClass(tableView)
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func initData(title: String, data: [InfoComicModel]){
        self.title = title
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
            make.bottom.equalTo(0)
        }
    }
}

extension LstComicViewController2 : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = LstComicTBViewCell.loadCell(tableView) as? LstComicTBViewCell else { return BaseTBCell() }
        cell.initData(imgHeight: COL_CELL_HEIGHT2, data: self.data[indexPath.row].similars[0])
        
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

