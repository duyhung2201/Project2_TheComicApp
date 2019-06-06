//
//  HomeCollectionViewCell.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var homeData: HomeModel? {
        didSet {
            if let data = homeData {
                self.imgView.kf.setImage(with: URL(string: data.imgUrl)!, options: [.requestModifier(modifier)]) { (image, error, cache, url) in
                    if let error = error {
                        print(error)
                    }
                }
                subTitleLabel.text = data.issueName
                subTitleLabel.textColor = .white
                titleLabel.text = data.title
                titleLabel.numberOfLines = 0
            }
        }
    }
    
    var similarData: SimilarComicModel? {
        didSet {
            if let data = similarData {
                self.imgView.kf.setImage(with: URL(string: data.imgUrl)!, options: [.requestModifier(modifier)]) { (image, error, cache, url) in
                    if let error = error {
                        print(error)
                    }
                }
                subTitleLabel.text = "Issue # \(data.numIssues)"
                subTitleLabel.textColor = .white
                titleLabel.text = data.title
                titleLabel.numberOfLines = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgView.layer.cornerRadius = 10
        self.imgView.layer.masksToBounds = true
        self.imgView.layer.borderWidth = 0
    }
}
