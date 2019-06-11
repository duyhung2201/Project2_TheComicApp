//
//  WriteReviewTBViewCell.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/10/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import Cosmos

class WriteReviewTBViewCell: BaseTBCell {
    lazy var reviewTxv: UITextView = {
        let reviewTxv = UITextView()
        reviewTxv.font = .systemFont(ofSize: 14)
//        reviewTxv.translatesAutoresizingMaskIntoConstraints = false
        reviewTxv.isScrollEnabled = false
        
        return reviewTxv
    }()
    lazy var placeHolderLbl: UILabel = {
        let placeHolderLbl = UILabel()
        placeHolderLbl.text = "Write a Review"
        placeHolderLbl.textColor = GRAY_COLOR
        placeHolderLbl.font = .systemFont(ofSize: 14)
        
        return placeHolderLbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(reviewTxv)
         self.contentView.addSubview(placeHolderLbl)
        initLayout()
        self.separatorInset = UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0)
        self.reviewTxv.delegate = self
        
        self.placeHolderLbl.isHidden = !reviewTxv.text.isEmpty
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func initLayout() {
        self.reviewTxv.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20)
            make.right.equalTo(-MARGIN20)
            make.top.equalTo(MARGIN20)
            make.bottom.equalTo(-MARGIN20)
            make.height.greaterThanOrEqualTo(SCREEN_HEIGHT - 210)
        }
        self.placeHolderLbl.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20+5)
            make.top.equalTo(MARGIN20+8)
        }
    }
    
}

extension WriteReviewTBViewCell: UITextViewDelegate {
//    func textViewDidChangeSelection(_ textView: UITextView) {
//        self.placeHolderLbl.isHidden = true
//    }
    func textViewDidChange(_ textView: UITextView) {
        self.placeHolderLbl.isHidden = !reviewTxv.text.isEmpty
    }
    
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if(reviewTxv.text.isEmpty){
//            self.placeHolderLbl.isHidden = false
//        }
//    }
}
