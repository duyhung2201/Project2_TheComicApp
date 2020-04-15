//
//  HeaderView.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/11/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    var imgHeight = 0
    
    lazy var avatar : UIImageView = {
        let avatar = UIImageView()
        avatar.layer.masksToBounds = true
        avatar.layer.cornerRadius = CGFloat(self.imgHeight/2)
        avatar.contentMode = .scaleToFill
        
        return avatar
    }()
    
    var title : UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 30)
        
        return title
    }()
    
    var sub_title : UILabel = {
        let sub_title = UILabel()
        sub_title.font = UIFont.boldSystemFont(ofSize: 14)
        sub_title.textColor = GRAY_COLOR
        
        return sub_title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        self.addSubview(avatar)
        self.addSubview(sub_title)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(imgHeight:Int, title: String, sub_title: String, imgUrl: String) {
        self.imgHeight = imgHeight
        avatar.image = UIImage(named: imgUrl)
        avatar.layer.cornerRadius = CGFloat(imgHeight/2)
        self.title.text = title
        self.sub_title.text = sub_title
        initLayout()
    }
    
    func initLayout() {
        self.sub_title.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20)
            make.top.equalTo(MARGIN7)
        }
        self.title.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20)
            make.top.equalTo(sub_title.snp.bottom)
            make.bottom.equalTo(-MARGIN7)
        }
        self.avatar.snp.makeConstraints { (make) in
            make.right.equalTo(-MARGIN20)
            make.centerY.equalTo(self)
            make.width.height.equalTo(self.imgHeight)
        }
    }

}
