//
//  ReviewContentCell.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/10/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import Cosmos

class ReviewContentCell: UIView {
    lazy var infoReviewLbl: UILabel = {
        let infoReviewLbl = UILabel()
        infoReviewLbl.textColor = GRAY_COLOR
        infoReviewLbl.font = .boldSystemFont(ofSize: 14)
        infoReviewLbl.textAlignment = .right
        infoReviewLbl.numberOfLines = 0
        
        return infoReviewLbl
    }()
    
    lazy var rating: CosmosView = {
        var options = CosmosSettings()
        options.updateOnTouch = false
        options.starSize = 20
        options.fillMode = .full
        options.starMargin = 1
        options.filledColor = .orange
        options.emptyBorderColor = .orange
        options.filledBorderColor = .orange
        let rating = CosmosView(settings: options)
        
        return rating
    }()
    
    lazy var commentLbl: UILabel = {
        let commentLbl = UILabel()
        commentLbl.font = .systemFont(ofSize: 14)
        commentLbl.numberOfLines = 0
        
        return commentLbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = LIGHT_GRAY_COLOR
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.addSubview(commentLbl)
        self.addSubview(infoReviewLbl)
        self.addSubview(rating)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(review: Review){
        self.rating.rating = Double(review.ratingPoint)
        self.commentLbl.text = review.reviewContent
        let usr_name = review.usr_name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        let date = dateFormatter.string(from: review.reviewed_at)
        
        self.infoReviewLbl.text = "\(date)\n\(usr_name)"
        
        initLayout()
    }
    
    func initLayout() {
        self.infoReviewLbl.snp.makeConstraints { (make) in
            make.top.equalTo(MARGIN10)
            make.right.equalTo(-MARGIN10)
            make.centerY.equalTo(rating)
        }
        self.rating.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN10)
        }
        self.commentLbl.snp.makeConstraints { (make) in
            make.left.equalTo(rating.snp.left)
            make.right.equalTo(infoReviewLbl.snp.right)
            make.top.equalTo(infoReviewLbl.snp.bottom).offset(MARGIN10)
        }
    }
}
