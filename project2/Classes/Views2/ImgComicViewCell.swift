//
//  ImgComicViewCell.swift
//  project2
//
//  Created by Macintosh on 6/7/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Cosmos


class ImgComicViewCell: UIView {
    var imgHeigh = 0
    var id_comic = 0
    var delegate : ReloadTBVCellDelegate?
    
    var favoriteState = true
    
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
        sub_title.font = UIFont.systemFont(ofSize: 14)
        sub_title.textColor = GRAY_COLOR
        
        return sub_title
    }()
    
    var ratingPoint : UILabel = {
        let ratingPoint = UILabel()
        ratingPoint.textColor = GRAY_COLOR
        ratingPoint.font = UIFont.boldSystemFont(ofSize: 20)
        
        return ratingPoint
    }()
    
    var rating: CosmosView = {
        var options = CosmosSettings()
        options.updateOnTouch = false
        options.starSize = 20
        options.fillMode = .precise
        options.starMargin = 0
        options.filledColor = GRAY_COLOR
        options.emptyBorderColor = GRAY_COLOR
        options.filledBorderColor = GRAY_COLOR
        
        let rating = CosmosView(settings: options)
        
        
        return rating
    }()
    
    var ratingCount: UILabel = {
        let ratingCount = UILabel()
        ratingCount.font = UIFont.systemFont(ofSize: 14)
        ratingCount.textColor = GRAY_COLOR
        
        return ratingCount
    }()
    
    var favoriteBtn : UILabel = {
        let favoriteBtn = UILabel()
        favoriteBtn.textAlignment = .center
        favoriteBtn.layer.masksToBounds = true
        favoriteBtn.layer.cornerRadius = 15
        favoriteBtn.text = "Like"
        favoriteBtn.font = UIFont.boldSystemFont(ofSize: 20)
        favoriteBtn.textColor = .white
        
        return favoriteBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(img)
        self.addSubview(title)
        self.addSubview(sub_title)
        self.addSubview(rating)
        self.addSubview(ratingPoint)
        self.addSubview(ratingCount)
        self.addSubview(favoriteBtn)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(imgHeight: Int, id_comic: Int, imgUrl: String, title: String, sub_title: String) {
        self.imgHeigh = imgHeight
        img.kf.setImage(with: URL(string: imgUrl), options: [.requestModifier(modifier)])
        self.title.text = title
        self.sub_title.text = sub_title
        self.id_comic = id_comic
        self.favoriteState = RealmManager.shared.isFavorited(id_comic: id_comic)
        
        let _rating = ["" : 1.2]
        self.rating.rating = _rating["rating_point"]!
        
        switch _rating["count"]! {
        case 0:
            ratingCount.text = "Not Enough Ratings"
            self.ratingPoint.text = "0"
        case 1:
            self.ratingPoint.text = "\(_rating["rating_point"]!)"
            ratingCount.text = "1 Rating"
        default:
            self.ratingPoint.text = "\(_rating["rating_point"]!)"
            ratingCount.text = "\(_rating["count"]!) Ratings"
        }
        
        self.updateFavoriteBtn()
        self.initLayout()
    }
    
    func initLayout() {
        setImgLayout()
        setTitleLayout()
        if (!(self.sub_title.text?.isEmpty)!){
            setSubTitleLayout()
        }
        setRatingLayout()
        setRatingCountLayout()
        setRatingPointLayout()
        setFavoriteBtnLayout()
    }
    
    
    
    func updateFavoriteBtn() {
        if favoriteState {
            favoriteBtn.backgroundColor = BLUE_COLOR
            
        }else {
            favoriteBtn.backgroundColor = GRAY_COLOR
        }
    }
    
    @objc func tapRating() {
        
    }
    
    @objc func tapFavorite() {
        if favoriteState {
            favoriteState = false
            favoriteBtn.backgroundColor = GRAY_COLOR
            RealmManager.shared.updateFavortie(id_comic: self.id_comic)
        }else {
            favoriteState = true
            favoriteBtn.backgroundColor = BLUE_COLOR
            RealmManager.shared.updateFavortie(id_comic: self.id_comic)
        }
    }
    
    //MARK : set Sub-Layout
    func setImgLayout() {
        self.img.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(imgHeigh*3/4)
            make.height.equalTo(imgHeigh)
        }
    }
    
    func setTitleLayout() {
        self.title.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.right.equalTo(self)
            make.top.equalTo(self)
        }
    }
    
    func setSubTitleLayout() {
        self.sub_title.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.right.equalTo(self)
            make.top.equalTo(title.snp.bottom).offset(1)
        }
    }
    
    func setRatingPointLayout() {
        self.ratingPoint.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
        }
    }
    
    func setRatingCountLayout() {
        self.ratingCount.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.top.equalTo(rating.snp.bottom).offset(1)
        }
    }
    
    func setFavoriteBtnLayout() {
        self.favoriteBtn.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.bottom.equalTo(img.snp.bottom)
            make.top.lessThanOrEqualTo(ratingCount.snp.bottom).offset(30)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        favoriteBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFavorite))
        favoriteBtn.addGestureRecognizer(tap)
    }
    
    func setRatingLayout() {
        self.rating.snp.makeConstraints { (make) in
            make.left.equalTo(ratingPoint.snp.right).offset(1)
            make.centerY.equalTo(ratingPoint).offset(1)
            make.top.greaterThanOrEqualTo(title.snp.bottom).offset(5)
        }
        rating.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRating))
        rating.addGestureRecognizer(tap)
    }
    
    
}
