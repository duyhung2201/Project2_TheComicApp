//
//  PageReading.swift
//  project2
//
//  Created by Macintosh on 3/19/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Kingfisher

class PageReadingViewController: UIViewController {
    var imgPage : UIImageView = {
        let imgPage = UIImageView()
        imgPage.contentMode = .scaleToFill
        
        return imgPage
    }()
    
    var numPageLbl : UILabel = {
        let numPageLbl = UILabel()
        numPageLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        return numPageLbl
    }()
    
    var index: Int = 0
    var urlImg: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(imgPage)
        self.view.addSubview(numPageLbl)
        
        numPageLbl.text = "Page \(1 + index)"       
        imgPage.kf.setImage(with: URL(string: urlImg.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), options: [.requestModifier(modifier)])
        initLayout()
    }
    
    func initLayout() {
        self.imgPage.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(self.view)
            make.top.equalTo(100)
            make.bottom.equalTo(-MARGIN20 - 10)
        }
        self.numPageLbl.snp.makeConstraints { (make) in
            make.top.equalTo(imgPage.snp.bottom).offset(5)
            make.right.equalTo(-MARGIN20)
        }
    }
}
