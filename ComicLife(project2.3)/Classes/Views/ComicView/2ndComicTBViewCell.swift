//
//  2ndComicTBViewCell.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/20/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit
import Cosmos

protocol SecondComicTBViewCellDelegate {
    func scrollToReview()
}

class SecondComicTBViewCell: BaseTBCell {
    var delegate : SecondComicTBViewCellDelegate?
    
    var ratingPoint : UILabel = {
        let ratingPoint = UILabel()
        ratingPoint.textColor = .darkGray
        ratingPoint.font = UIFont.boldSystemFont(ofSize: 20)
        
        return ratingPoint
    }()
    
    lazy var rating: CosmosView = {
        var options = CosmosSettings()
        options.updateOnTouch = false
        options.starSize = 20
        options.fillMode = .precise
        options.starMargin = 1
        options.filledColor = .darkGray
        options.emptyBorderColor = .darkGray
        options.filledBorderColor = .darkGray
        let rating = CosmosView(settings: options)
        rating.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapRating))
        rating.addGestureRecognizer(tap)
        
        return rating
    }()
    @objc func tapRating() {
        delegate?.scrollToReview()
    }
    
    var ratingCount: UILabel = {
        let ratingCount = UILabel()
        ratingCount.font = UIFont.boldSystemFont(ofSize: 14)
        ratingCount.textColor = GRAY_COLOR
        
        
        return ratingCount
    }()
    
    lazy var fvrCountLbl: UILabel = {
        let favoriteCountLbl = UILabel()
        favoriteCountLbl.numberOfLines = 0
        favoriteCountLbl.textAlignment = .center
        
        return favoriteCountLbl
    }()
    
    lazy var reviewCountLbl: UILabel = {
        let cmtCountLbl = UILabel()
        cmtCountLbl.numberOfLines = 0
        cmtCountLbl.textAlignment = .center
        
        return cmtCountLbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(rating)
        self.contentView.addSubview(ratingPoint)
        self.contentView.addSubview(ratingCount)
        self.contentView.addSubview(reviewCountLbl)
        self.contentView.addSubview(fvrCountLbl)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(ratingCount: Int, ratingPoint: Double, fvrCount: Int, reviewCount: Int) {
        self.rating.rating = ratingPoint
        self.reviewCountLbl.attributedText = setAttText(num: reviewCount, str: "Reviews")
        self.fvrCountLbl.attributedText = setAttText(num: fvrCount, str: "Likes")
        
        switch ratingCount{
        case 0:
            self.ratingCount.text = "Not Enough Ratings"
            self.ratingPoint.text = "0"
        case 1:
            self.ratingPoint.text = "\(ratingPoint)"
            self.ratingCount.text = "1 Rating"
        default:
            self.ratingPoint.text = "\(ratingPoint)"
            self.ratingCount.text = "\(ratingCount) Ratings"
        }
        
        self.initLayout()
    }
    
    func initLayout() {
        setRatingLayout()
        setRatingCountLayout()
        setRatingPointLayout()
        setReviewCountLayout()
        setFvrCountLayout()
    }
    
    func setAttText(num: Int, str: String) -> NSAttributedString{
        let numAtt = NSMutableAttributedString(string: "\(num)\n", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20)])
        let strAtt = NSAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor : GRAY_COLOR, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 14)])
        numAtt.append(strAtt)
        
        return numAtt
    }
    
    //MARK : set Sub-Layout
   
    
   
    
    func setRatingPointLayout() {
        self.ratingPoint.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20)
            make.top.equalTo(MARGIN20)
        }
    }
    func setRatingLayout() {
        self.rating.snp.makeConstraints { (make) in
            make.left.equalTo(ratingPoint.snp.right).offset(2)
            make.centerY.equalTo(ratingPoint)
        }
    }
    func setRatingCountLayout() {
        self.ratingCount.snp.makeConstraints { (make) in
            make.left.equalTo(ratingPoint.snp.left)
            make.top.equalTo(rating.snp.bottom)
            make.bottom.equalTo(-MARGIN20)
        }
    }
    func setFvrCountLayout() {
        self.fvrCountLbl.snp.makeConstraints { (make) in
            make.right.equalTo(-MARGIN20)
            make.top.equalTo(ratingPoint.snp.top)
        }
    }
    func setReviewCountLayout() {
        let midView = UIView()
        self.addSubview(midView)
        midView.snp.makeConstraints { (make) in
            make.left.equalTo(rating.snp.right)
            make.right.equalTo(fvrCountLbl.snp.left)
        }
        
        self.reviewCountLbl.snp.makeConstraints { (make) in
            make.top.equalTo(ratingPoint.snp.top)
            make.centerX.equalTo(midView)
        }
    }
 
}
