//
//  SummaryComicTBViewCell.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class SummaryComicTBViewCell: BaseTBCell {
    
    lazy var titleLbl : UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = UIFont.boldSystemFont(ofSize: 20)
        titleLbl.numberOfLines = 0
        return titleLbl
    }()
    
    lazy var summaryLbl : UILabel = {
        let summaryLbl = UILabel()
        summaryLbl.font = .italicSystemFont(ofSize: 14)
        summaryLbl.numberOfLines = 0
        summaryLbl.textAlignment = .justified
        
        return summaryLbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(summaryLbl)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(title: String, summary: String){
        self.titleLbl.text = title
        self.summaryLbl.text = summary
        
        initLayout()
    }

    func initLayout() {
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN20)
        }
        self.summaryLbl.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20)
            make.right.bottom.equalTo(-MARGIN20)
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
        }
    }
    
}
