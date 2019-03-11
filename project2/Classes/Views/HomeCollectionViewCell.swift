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
    
    var data: ComicHomeModel? {
        didSet {
            if let data = data {
                self.imgView.kf.setImage(with: URL(string: data.imgUrl)!, options: [.requestModifier(modifier)]) { (image, error, cache, url) in
                    if let error = error {
                        print(error)
                    }
                }
                
                subTitleLabel.text = data.issueName
                
                titleLabel.text = data.title
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
