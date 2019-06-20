//
//  ComicTopTBViewCell.swift
//  project2
//
//  Created by Macintosh on 6/8/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Cosmos

protocol TopTBCellDelegate {
    func pushToLstIssue(id_comic: Int)
    func scrollToReview()
}

class TopComicTBViewCell: BaseTBCell {
    var id_comic = 0
    var delegate : TopTBCellDelegate?
    var favoriteState = true {
        didSet{
            self.updateFavoriteBtn()
        }
    }
    
    var img : UIImageView = {
        let img = UIImageView()
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 10
        img.contentMode = .scaleToFill
        
        return img
    }()
    
    var title : UILabel = {
        let title = UILabel()
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
    
    lazy var favoriteBtn : UILabel = {
        let favoriteBtn = UILabel()
        favoriteBtn.text = "LIKE"
        favoriteBtn.font = UIFont.boldSystemFont(ofSize: 20)
        favoriteBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFavorite))
        favoriteBtn.addGestureRecognizer(tap)
        
        return favoriteBtn
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
        self.contentView.addSubview(img)
        self.contentView.addSubview(title)
        self.contentView.addSubview(sub_title)
        self.contentView.addSubview(favoriteBtn)
        self.contentView.addSubview(readBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(imgHeight: Int, id_comic: Int, imgUrl: String, title: String, sub_title: String, fvrState: Bool) {
        img.kf.setImage(with: URL(string: imgUrl), options: [.requestModifier(modifier)])
        self.title.text = title
        self.sub_title.text = sub_title
        self.id_comic = id_comic
        self.favoriteState = fvrState
        
        self.initLayout(imgHeight: imgHeight)
    }
    
    func initLayout(imgHeight: Int) {
        setImgLayout(imgHeight: imgHeight)
        setTitleLayout()
        setSubTitleLayout()
        setReadBtnLayout()
        setFvrBtnLayout()
        self.separatorInset = UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0)
    }
    
    func setAttText(num: Int, str: String) -> NSAttributedString{
        let numAtt = NSMutableAttributedString(string: "\(num)\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
        let strAtt = NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor : GRAY_COLOR, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        numAtt.append(strAtt)
        
        return numAtt
    }
    
    func updateFavoriteBtn() {
        if favoriteState {
            favoriteBtn.text = "❤️"
            
        }else {
            favoriteBtn.text = "♡"
        }
    }
    
    
    @objc func tapFavorite() {
        if favoriteState {
            favoriteState = false
            favoriteBtn.text = "♡"
            
            RealmManager.shared.updateFavortie(id_comic: self.id_comic)
        }else {
            favoriteState = true
            favoriteBtn.text = "❤️"
            RealmManager.shared.updateFavortie(id_comic: self.id_comic)
        }
    }
    
    @objc func tapRead() {
        delegate?.pushToLstIssue(id_comic: self.id_comic)
    }
    
    //MARK : set Sub-Layout
    func setImgLayout(imgHeight: Int) {
        self.img.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20)
            make.top.equalTo(MARGIN20)
            make.bottom.equalTo(0)
            make.width.equalTo(imgHeight*3/4)
            make.height.equalTo(imgHeight)
        }
    }
    
    func setTitleLayout() {
        self.title.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(MARGIN15)
            make.right.equalTo(-MARGIN20)
            make.top.equalTo(img.snp.top)
        }
    }
    
    func setSubTitleLayout() {
        self.sub_title.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(MARGIN15)
            make.right.equalTo(self)
            make.top.equalTo(title.snp.bottom).offset(1)
        }
    }
    
    func setReadBtnLayout() {
        self.readBtn.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(MARGIN15)
            make.bottom.equalTo(img.snp.bottom)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    func setFvrBtnLayout() {
        self.favoriteBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-MARGIN20)
            make.bottom.equalTo(img.snp.bottom)
            make.height.equalTo(30)
        }
    }
    
}
