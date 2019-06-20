//
//  LoadView.swift
//  
//
//  Created by Macintosh on 3/24/19.
//

import UIKit
import SnapKit

class LoadView: UIView {
    
    lazy var gif : UIImageView = {
        
        let gif = UIImageView(image: UIImage.gifImageWithName("superman"))
        gif.frame = UIScreen.main.bounds

        gif.backgroundColor = .blue
        
        return gif
    }()
    
    lazy var loadingLbl : UILabel = {
        let loadingLbl = UILabel()
        loadingLbl.text = "Loading..."
        loadingLbl.textAlignment = .center
        loadingLbl.font = UIFont.boldSystemFont(ofSize: 20)
        
        return loadingLbl
    }()
    
    lazy var loadIcon : UIActivityIndicatorView = {
        let loadIcon = UIActivityIndicatorView()
        loadIcon.style = .gray
        loadIcon.backgroundColor = .red
        
        return loadIcon
    }()
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        self.addSubview(gif)
        self.addSubview(loadingLbl)
        self.addSubview(loadIcon)
        setLoadingLbl()
        setLoadIcon()
    }
    
    func setLoadingLbl() {
        self.loadingLbl.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self.snp.bottom).offset(-80)
        }
    }
    
    func setLoadIcon() {
        self.loadIcon.snp.makeConstraints { (make) in
            make.top.equalTo(loadingLbl).offset(10)
            make.centerX.equalTo(self)
            make.width.height.equalTo(20)
        }
    }

}
