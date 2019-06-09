//
//  InfoComicTBCell.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class InfoComicTBViewCell: BaseTBCell {
    var data = [LineInfoComicModel]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var titleLbl : UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = UIFont.boldSystemFont(ofSize: 20)
        
        return titleLbl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = #colorLiteral(red: 0.9198487122, green: 0.9198487122, blue: 0.9198487122, alpha: 1)
        LineInfoComicTBViewCell.registerCellByClass(tableView)
        
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(title: String, data: [LineInfoComicModel]){
        self.titleLbl.text = title
        self.data = data
        
        initLayout()
    }
    
    func initLayout() {
        self.titleLbl.snp.makeConstraints { (make) in
            make.top.left.equalTo(MARGIN)
        }
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN)
            make.right.equalTo(-MARGIN)
            make.top.equalTo(titleLbl.snp.bottom).offset(10)
            make.height.equalTo(33 * CGFloat(data.count) + 30)
            make.bottom.equalTo(-MARGIN)
        }

    }
    
}

extension InfoComicTBViewCell : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        guard let cell = LineInfoComicTBViewCell.loadCell(tableView) as? LineInfoComicTBViewCell else { return BaseTBCell() }
        cell.initData(title: data[indexPath.row].title, detail: data[indexPath.row].detail)
        if (indexPath.row == (self.data.count) - 1){
            cell.title.textColor = BLUE_COLOR
            cell.separatorInset = UIEdgeInsets(top: 0, left: self.tableView.frame.width, bottom: 0, right: 0)
        }

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.data.count)
    }
    
}
