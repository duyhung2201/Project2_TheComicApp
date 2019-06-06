//
//  HomeCLViewCell2.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SnapKit

class HomeCLViewCell2: BaseCLCell {
    var data: HomeModel?{
        didSet{
            if let data = data {
                setImgComicView(data: data)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setImgComicView(data: HomeModel) {
        let imgUrl = data.imgUrl
        let title = data.title
        let issue_name = data.issueName
        let id = data.id

        let imgComicView = ImgComicView(imgUrl: imgUrl, title: title, issue_name: issue_name, id_comic: id)
        imgComicView.tag = 100
        
        if let oldView = self.viewWithTag(100) {
            oldView.removeFromSuperview()
        }
        self.addSubview(imgComicView)
        
        imgComicView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
}
