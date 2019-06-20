//
//  ReviewCLViewCell.swift
//  project2
//
//  Created by Macintosh on 6/9/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Cosmos

class ReviewCLViewCell: BaseCLCell {
    var reviewContentCell = ReviewContentCell()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(reviewContentCell)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(review: Review){
        reviewContentCell.initData(review: review)
        
        initLayout()
    }

    func initLayout() {
        self.reviewContentCell.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
}
