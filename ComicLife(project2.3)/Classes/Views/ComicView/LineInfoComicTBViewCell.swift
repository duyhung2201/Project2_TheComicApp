//
//  LineInfoComicTBViewCell.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class LineInfoComicTBViewCell: BaseTBCell {
    lazy var title: UILabel = {
        let title = UILabel()
        title.textColor = GRAY_COLOR
        title.font = UIFont.systemFont(ofSize: 14)
        
        return title
    }()
    
    lazy var detail: UILabel = {
       let detail = UILabel()
        detail.textAlignment = .left
        detail.font = UIFont.systemFont(ofSize: 14)
        detail.numberOfLines = 0
        
        return detail
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(title)
        self.addSubview(detail)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(title: String, detail: String){
        self.title.text = title
        self.detail.text = detail
        initLayout()
    }
    
    func initLayout() {
        self.title.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN7)
        }
        self.detail.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-MARGIN7)
            make.top.equalTo(title.snp.top)
            make.width.lessThanOrEqualTo(self.frame.width*3/4)
            
        }
    }
}
