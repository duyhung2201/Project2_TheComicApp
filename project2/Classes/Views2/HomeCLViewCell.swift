//
//  HomeCLViewCell2.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class HomeCLViewCell: BaseCLCell {
    var data: HomeModel?{
        didSet{
            if let data = data {
                setImgComicView(data: data)
            }
        }
    }
    
    var imgComicViewCell = ImgComicView()
    var imgHeight = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imgComicViewCell)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(imgHeight: Int, data: HomeModel){
        self.imgHeight = imgHeight
        self.data = data
        
        setUpContentView()
    }
    
    func setUpContentView() {
        imgComicViewCell.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    func setImgComicView(data: HomeModel) {
        imgComicViewCell.initData(imgHeight: self.imgHeight, id_comic: data.id, imgUrl: data.imgUrl, title: data.title, sub_title: data.issueName) 
    }
}
