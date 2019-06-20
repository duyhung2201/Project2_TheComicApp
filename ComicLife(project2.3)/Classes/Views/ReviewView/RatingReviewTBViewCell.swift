//
//  RatingReviewTBViewCell.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/10/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import Cosmos

protocol SubmitDelegate {
    func enableSubmit()
}

class RatingReviewTBViewCell: BaseTBCell {
    var delegate :SubmitDelegate?
    
    lazy var rating: CosmosView = {
        var options = CosmosSettings()
        options.updateOnTouch = true
        options.starSize = 30
        options.fillMode = .full
        options.starMargin = 3
        options.filledColor = BLUE_COLOR
        options.emptyBorderColor = BLUE_COLOR
        options.filledBorderColor = BLUE_COLOR
        let rating = CosmosView(settings: options)
        rating.rating = 0
        
        rating.didFinishTouchingCosmos = { (ratingPoint) in
            rating.rating = ratingPoint
            self.delegate!.enableSubmit()
        }
        
        return rating
    }()
    
    lazy var tapToRateLbl: UILabel = {
        let tapToRateLbl = UILabel()
        tapToRateLbl.textColor = GRAY_COLOR
        tapToRateLbl.text = "Tap to Rate:"
        tapToRateLbl.font = .systemFont(ofSize: 14)
        
        return tapToRateLbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(rating)
        self.contentView.addSubview(tapToRateLbl)
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initLayout() {
        self.tapToRateLbl.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20)
            make.centerY.equalTo(rating)
        }
        self.rating.snp.makeConstraints { (make) in
            make.right.equalTo(-MARGIN20)
            make.top.equalTo(MARGIN20)
            make.bottom.equalTo(-MARGIN20)
        }
    }
}
