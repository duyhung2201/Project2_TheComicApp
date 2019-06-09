//
//  AllCateTBViewCell.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class ImgComicTBViewCell: BaseTBCell {
    
    var imgComicView: ImgComicView = ImgComicView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(imgComicView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initData(imgHeight: Int, id_comic: Int, imgUrl: String, title: String, sub_title: String) {
        
        imgComicView.initData(imgHeight: imgHeight, id_comic: id_comic, imgUrl: imgUrl, title: title, sub_title: sub_title)
        setUpContentView()
    }

    func setUpContentView() {
        imgComicView.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN)
            make.right.bottom.equalTo(-MARGIN)
        }
    }
    
}
