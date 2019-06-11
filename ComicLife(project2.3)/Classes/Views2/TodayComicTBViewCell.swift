//
//  TodayComicTBViewCell.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/11/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

class TodayComicTBViewCell: BaseTBCell {
    var id_comic = 0
    var imgHeight = 0
    
    var img : UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 10
        img.contentMode = .scaleToFill
        
        return img
    }()
    
    var title : UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 20)
        
        return title
    }()
    
    var sub_title : UILabel = {
        let sub_title = UILabel()
        sub_title.font = UIFont.boldSystemFont(ofSize: 14)
        sub_title.textColor = GRAY_COLOR
        
        return sub_title
    }()
    
    lazy var readBtn: UILabel = {
        let readBtn = UILabel()
        readBtn.textColor = .white
        readBtn.backgroundColor = BLUE_COLOR
        readBtn.text = "READ"
        readBtn.textAlignment = .center
        readBtn.layer.masksToBounds = true
        readBtn.layer.cornerRadius = 15
        readBtn.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight(rawValue: 10))
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRead))
        readBtn.addGestureRecognizer(tap)
        readBtn.isUserInteractionEnabled = true
        
        return readBtn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.separatorInset = UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0)
        self.contentView.addSubview(title)
        self.contentView.addSubview(readBtn)
        self.contentView.addSubview(img)
        self.contentView.addSubview(sub_title)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(imgHeight: Int, data: HomeModel){
        self.id_comic = data.id
        self.title.text = data.title
        self.img.kf.setImage(with: URL(string: data.imgUrl), options: [.requestModifier(modifier)])
        self.sub_title.text = data.issueName
        initLayout()
    }
    
    @objc func tapRead() {
        
    }
    
    func initLayout() {
        self.img.snp.makeConstraints { (make) in
            make.right.equalTo(-MARGIN20)
            make.bottom.equalTo(-MARGIN20)
            make.left.equalTo(MARGIN20)
            make.top.equalTo(MARGIN20)
            make.width.equalTo(SCREEN_WIDTH - 2*MARGIN20)
            make.height.equalTo((SCREEN_WIDTH - 2*MARGIN20)*4/3)
        }
        self.title.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.left).offset(MARGIN10)
            make.width.equalTo(imgHeight*3/4*3/4)
        }
        self.sub_title.snp.makeConstraints { (make) in
           make.left.equalTo(img.snp.left).offset(MARGIN10)
            make.top.equalTo(title.snp.bottom)
            make.bottom.equalTo(img.snp.bottom).offset(-MARGIN10)
        }
        self.readBtn.snp.makeConstraints { (make) in
            make.right.equalTo(img.snp.right).offset(-MARGIN10)
            make.bottom.equalTo(img.snp.bottom).offset(-MARGIN10)
        }
    }
    
}
