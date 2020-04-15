//
//  ReviewTBViewCell.swift
//  project2
//
//  Created by Macintosh on 6/7/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Cosmos
import SnapKit

protocol ReviewTBCellDelegate {
    func pushVCToLstReview()
    func pushVCToWriteReView()
}

class ReviewTBViewCell: BaseTBCell {
    lazy var cellIndexPath = 0
    lazy var id_comic = 0
    lazy var isInRecently = false
    var delegate : ReviewTBCellDelegate?
    var height = 0
    var data = [Review]()
    
    fileprivate var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = .boldSystemFont(ofSize: 20)
        
        return titleLbl
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let rect = CGRect(x: CGFloat(0), y:50, width: SCREEN_WIDTH, height: 180)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    lazy var seeAllLbl: UILabel = {
        let seeAllLbl = UILabel()
        seeAllLbl.textColor = BLUE_COLOR
        seeAllLbl.font = .systemFont(ofSize: 14)
        seeAllLbl.text = "See All"
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSeeAll))
        seeAllLbl.addGestureRecognizer(tap)
        seeAllLbl.isUserInteractionEnabled = true
        
        return seeAllLbl
    }()
    
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
            RealmManager.shared.addRating(id_comic: self.id_comic, rating_point: Int(ratingPoint))
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
    
    lazy var writeReviewLbl: UILabel = {
        let writeReviewLbl = UILabel()
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "cmt_icon20px")
        let attIcon = NSAttributedString(attachment: icon)
        let attText = NSAttributedString(string: " Write a Review")
        let text = NSMutableAttributedString()
        text.append(attIcon)
        text.append(attText)
        
        writeReviewLbl.attributedText = text
        writeReviewLbl.font = .systemFont(ofSize: 14)
        writeReviewLbl.textColor = BLUE_COLOR
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapReview))
        writeReviewLbl.addGestureRecognizer(tap)
        writeReviewLbl.isUserInteractionEnabled = true
        
        return writeReviewLbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(seeAllLbl)
        self.contentView.addSubview(tapToRateLbl)
        self.contentView.addSubview(rating)
        self.contentView.addSubview(writeReviewLbl)
        configCLView()
        addGestureForCLView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(id_comic: Int ,height: Int,title: String, data: [Review]) {
        self.titleLbl.text = title
        self.data = data 
        self.height = height
        self.id_comic = id_comic
        self.isInRecently = RealmManager.shared.user.isInRecently(id_comic: id_comic) 
        initLayout()
        updateView()
    }
    
    func addGestureForCLView() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.collectionView.addGestureRecognizer(swipeLeft)
        self.collectionView.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeLeft(){
        if cellIndexPath < data.count - 1  {
            cellIndexPath += 1
            collectionView.scrollToItem(at: IndexPath(item: self.cellIndexPath, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        
    }
    @objc func swipeRight(){
        if cellIndexPath > 0 {
            cellIndexPath -= 1
            collectionView.scrollToItem(at: IndexPath(item: self.cellIndexPath, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
    }
    func updateView() {
        if (isInRecently){
            self.rating.isHidden = false
            self.tapToRateLbl.isHidden = false
            self.writeReviewLbl.isHidden = false
        }
        else{
            self.rating.isHidden = true
            self.tapToRateLbl.isHidden = true
            self.writeReviewLbl.isHidden = true
        }
    }
    
    func configCLView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        ReviewCLViewCell.registerCellByClass(self.collectionView)
        EmptyReviewCLViewCell.registerCellByClass(self.collectionView)
    }
    @objc func tapSeeAll() {
        delegate?.pushVCToLstReview()
    }
    @objc func tapReview() {
        delegate?.pushVCToWriteReView()
    }
    
    var clHeight : Constraint!
    //MARK: set layout
    func initLayout() {
//        self.titleLbl.snp.makeConstraints { (make) in
//            make.left.top.equalTo(MARGIN20)
//        }
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(rating.snp.bottom).offset(5)
            make.right.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            clHeight = make.height.equalTo(self.height).constraint
        }
//        self.seeAllLbl.snp.makeConstraints { (make) in
//            make.right.equalTo(-MARGIN20)
//            make.centerY.equalTo(titleLbl)
//        }
//        self.tapToRateLbl.snp.makeConstraints { (make) in
//            make.left.equalTo(MARGIN20)
//            make.centerY.equalTo(rating)
//        }
//        self.rating.snp.makeConstraints { (make) in
//            make.right.equalTo(-MARGIN20)
//            make.top.equalTo(titleLbl.snp.bottom).offset(0)
//        }
//        self.writeReviewLbl.snp.makeConstraints { (make) in
//            make.left.equalTo(MARGIN20)
//            make.top.equalTo(collectionView.snp.bottom).offset(5)
//            make.bottom.equalTo(-MARGIN20)
//        }
    }
    
    func updateHeight() {
        self.clHeight.update(offset: 300)
        self.updateConstraints()
    }
    
}

extension ReviewTBViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH - 2*MARGIN20, height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if data.count > 0 {
            return data.count
        } else {
            return 1
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if data.count > 0 {
            guard let cell = ReviewCLViewCell.loadCell(self.collectionView, path: indexPath) as? ReviewCLViewCell else{
                return BaseCLCell()
            }
            cell.initData(review: data[indexPath.row])
            return cell
        } else {
            guard let cell = EmptyReviewCLViewCell.loadCell(self.collectionView, path: indexPath) as? EmptyReviewCLViewCell else{
                return BaseCLCell()
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        delegate?.pushVCToComic(id_comic: data[indexPath.row].id)
    }
    
}
