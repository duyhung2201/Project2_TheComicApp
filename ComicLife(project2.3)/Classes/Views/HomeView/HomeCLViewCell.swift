//
//  HomeCLViewCell2.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SnapKit

class HomeCLViewCell: BaseCLCell {
    
    var imgComicView = ImgComicView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(imgComicView)
        
//        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOffset = CGSize(width: 0, height: 1.0)
//        layer.shadowOpacity = 2
//        layer.shadowRadius = 4.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initData(imgHeight: Int, data: HomeModel){
        
        imgComicView.initData(imgHeight: imgHeight,
                                  id_comic: data.id,
                                  imgUrl: data.imgUrl,
                                  title: data.title,
                                  sub_title: data.issueName,
                                  favoriteState: true,
                                  ratingPoint: 4.0,
                                  ratingCount: 12)
        
        setUpLayout()
    }
    
   
    
    func setUpLayout() {
        imgComicView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
}
