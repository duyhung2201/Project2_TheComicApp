//
//  AllCateTBViewCell.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class LstComicTBViewCell: BaseTBCell {
    
    var imgComicView: ImgComicView = ImgComicView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(imgComicView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initData(imgHeight: Int, data: HomeModel) {
        let realmData = RealmManager.shared.getRealmComicData(id_comic: data.id)
        imgComicView.initData(imgHeight: imgHeight,
                                  id_comic: data.id,
                                  imgUrl: data.imgUrl,
                                  title: data.title,
                                  sub_title: "",
                                  favoriteState: realmData[RealmComicTypeData.fvrState.rawValue]! as! Bool,
                                  ratingPoint: realmData[RealmComicTypeData.ratingPoint.rawValue]! as! Double,
                                  ratingCount: realmData[RealmComicTypeData.ratingCount.rawValue]! as! Int)
        setUpContentView()
    }

    func setUpContentView() {
        imgComicView.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN20)
            make.right.bottom.equalTo(-MARGIN20)
        }
    }
    
}
