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
    
    var imgComicView: ImgComicView = ImgComicView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imgComicView)
        setUpContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContentView() {
        imgComicView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func setImgComicView(data: HomeModel) {
        imgComicView.data = data
    }
}
