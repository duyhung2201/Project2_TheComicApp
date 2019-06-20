//
//  EmptyReviewCLViewCell.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/10/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class EmptyReviewCLViewCell: BaseCLCell {
    
    var descriptionLbl : UILabel = {
        let descriptionLbl = UILabel()
        descriptionLbl.text = "No Review"
//        descriptionLbl.font = .systemFont(ofSize: 20)
        
        return descriptionLbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = LIGHT_GRAY_COLOR
       self.contentView.addSubview(descriptionLbl)
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func initLayout() {
        self.descriptionLbl.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(self)
        }
    }
}
