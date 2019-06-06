//
//  ImgComicView.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SnapKit
import Cosmos
import Kingfisher

class ImgComicView: UIView {
    var imgUrl = ""
    var _title = ""
    var _issue_name = ""
    var _rating_star = 0.0
    var _ratingCount = 0
    var favoriteState = false
    
    lazy var img : UIImageView = {
        let img = UIImageView()
        img.kf.setImage(with: URL(string: imgUrl), options: [.requestModifier(modifier)])
        img.layer.masksToBounds = true
        img.layer.cornerRadius = 10
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    lazy var title : UILabel = {
        let title = UILabel()
        title.text = _title
        title.font = UIFont.boldSystemFont(ofSize: 20)
        
        return title
    }()
    
    lazy var issue_name : UILabel = {
        let issue_name = UILabel()
        issue_name.text = "𝐍𝐞𝐰𝐞𝐬𝐭 𝐜𝐡𝐚𝐩𝐭𝐞𝐫: \(_issue_name)"
        issue_name.font = UIFont.systemFont(ofSize: 13)
        issue_name.textColor = .lightGray
        
        return issue_name
    }()
    
    lazy var ratingPoint : UILabel = {
       let ratingPoint = UILabel()
        ratingPoint.text = "\(_rating_star)"
        ratingPoint.textColor = .gray
        ratingPoint.font = UIFont.systemFont(ofSize: 20)
        
        return ratingPoint
    }()
    
    lazy var rating: CosmosView = {
        var options = CosmosSettings()
        options.updateOnTouch = false
        options.starSize = 20
        options.fillMode = .precise
        options.starMargin = 0
        options.filledColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        options.emptyBorderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        options.filledBorderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        
        let rating = CosmosView(settings: options)
        rating.rating = _rating_star

        return rating
    }()
    
    lazy var ratingCount: UILabel = {
        let ratingCount = UILabel()
        ratingCount.font = UIFont.systemFont(ofSize: 10)
        ratingCount.textColor = .lightGray
        
        switch _ratingCount {
        case 0:
            ratingCount.text = "Not Enough Ratings"
        case 1:
            ratingCount.text = "1 Rating"
        default:
            ratingCount.text = "\(_ratingCount) Ratings"
        }
        
        return ratingCount
    }()
    
    lazy var favoriteBtn : UILabel = {
        let favoriteBtn = UILabel()
        favoriteBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        favoriteBtn.textAlignment = .center
        favoriteBtn.layer.masksToBounds = true
        favoriteBtn.layer.cornerRadius = 15
        favoriteBtn.layer.borderWidth = 1
        favoriteBtn.text = "Like"
        favoriteBtn.font = UIFont.boldSystemFont(ofSize: 15)
        
        favoriteBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFavorite))
        favoriteBtn.addGestureRecognizer(tap)
        
       return favoriteBtn
    }()
    
    convenience init(imgUrl: String, title: String, issue_name: String,
                     id_comic: Int) {
        self.init()
        let rating = RealmManager.shared.getComicRating(id_comic: id_comic)
        initData(imgUrl: imgUrl, title: title, issue_name: issue_name, rating_star: rating["rating_star"]!, ratingCount: Int(rating["count"]!))
        initLayout()
    }
    
    func initData(imgUrl: String, title: String, issue_name: String,
                  rating_star: Double, ratingCount: Int) {
        self.imgUrl = imgUrl
        self._title = title
        self._issue_name = issue_name
        self._rating_star = rating_star
        self._ratingCount = ratingCount
        
    }

    func initLayout() {
        self.addSubview(img)
        self.addSubview(title)
        self.addSubview(issue_name)
        self.addSubview(rating)
        self.addSubview(ratingPoint)
        self.addSubview(ratingCount)
        self.addSubview(favoriteBtn)
        setImgLayout()
        setTitleLayout()
        setIssueNameLayout()
        setRatingLayout()
        setRatingCountLayout()
        if (_ratingCount != 0){
            setRatingPointLayout()
        }
        setFavoriteBtn()
    }
    
    func setImgLayout() {
        self.img.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
            make.width.equalTo(COL_CELL_HEIGHT*2/3)
            make.height.equalTo(COL_CELL_HEIGHT)
        }
    }
    
    func setTitleLayout() {
        self.title.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.right.equalTo(self)
            make.top.equalTo(self)
        }
    }
    
    func setIssueNameLayout() {
        self.issue_name.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.right.equalTo(self)
            make.top.equalTo(title.snp.bottom).offset(1)
        }
    }
    
    func setRatingPointLayout() {
        self.ratingPoint.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.top.equalTo(issue_name.snp.bottom).offset(10)
        }
    }
    
    func setRatingCountLayout() {
        self.ratingCount.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.top.equalTo(rating.snp.bottom).offset(1)
        }
    }
    
    func setFavoriteBtn() {
        self.favoriteBtn.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).offset(10)
            make.bottom.equalTo(img.snp.bottom)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
    }
    
    func setRatingLayout() {
        self.rating.snp.makeConstraints { (make) in
            if _ratingCount == 0{
                make.left.equalTo(img.snp.right).offset(10)
            }else {
                make.left.equalTo(ratingPoint.snp.right).offset(1)
                make.centerY.equalTo(ratingPoint).offset(1)
            }
            make.top.equalTo(issue_name.snp.bottom).offset(10)
            
        }
        
        rating.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRating))
        rating.addGestureRecognizer(tap)
    }
    
    @objc func tapRating() {
        print("tap")
    }
    
    @objc func tapFavorite() {
        if favoriteState {
            favoriteState = false
            favoriteBtn.textColor = .black
            
        }else {
            favoriteState = true
            favoriteBtn.textColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        }
        
    }
    
    
        
}
