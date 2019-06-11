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
        self.contentView.addSubview(imgComicView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(imgHeight: Int, data: HomeModel){
        let realmData = RealmManager.shared.getRealmComicData(id_comic: data.id)
        
        imgComicView.initData(imgHeight: imgHeight,
                                  id_comic: data.id,
                                  imgUrl: data.imgUrl,
                                  title: data.title,
                                  sub_title: data.issueName,
                                  favoriteState: realmData[RealmComicTypeData.fvrState.rawValue]! as! Bool,
                                  ratingPoint: realmData[RealmComicTypeData.ratingPoint.rawValue]! as! Double,
                                  ratingCount: realmData[RealmComicTypeData.ratingCount.rawValue]! as! Int)
        
        setUpLayout()
    }
    
   
    
    func setUpLayout() {
        imgComicView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
}
