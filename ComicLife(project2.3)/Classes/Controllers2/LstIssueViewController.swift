//
//  LstIssueViewController.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/10/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class LstIssueViewController: UIViewController {
    var data = [Issues]()
    var id_comic = 0
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
        tableView.tableFooterView = UIView(frame: .zero)
        SummaryComicTBViewCell.registerCellByClass(tableView)
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "All of Chapters"
        initLayout()
    }
    
    func initData(id_comic: Int, data: [Issues]){
        self.data = data
        self.id_comic = id_comic
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
            make.bottom.equalTo(-MARGIN20)
        }
    }
}

extension LstIssueViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = SummaryComicTBViewCell.loadCell(tableView) as? SummaryComicTBViewCell else { return BaseTBCell() }
        cell.initData(title: "Chapter: # \(indexPath.row)", summary: data[indexPath.row].title)
        cell.titleLbl.font = UIFont.boldSystemFont(ofSize: 15)
        
        if(indexPath.row == data.count){
            cell.separatorInset = UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0)
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RealmManager.shared.addRecent(id_comic: self.id_comic)
        let vc = IssueReading()
        vc.initData(id_issue: self.data[indexPath.row]._id)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
