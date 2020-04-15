//
//  CustomNavigationBar.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/21/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

protocol CustomNavigationBarDelegate {
    func popViewController()
    func readComic()
}

class CustomNavigationBar: UIView {
    var delegate: CustomNavigationBarDelegate?
    
    lazy var backBtn: UIImageView = {
        let backBtn = UIImageView(image: UIImage(named: "back"))
        let tap = UITapGestureRecognizer(target: self, action: #selector(back))
        backBtn.addGestureRecognizer(tap)
        backBtn.isUserInteractionEnabled = true
        
        return backBtn
    }()
    
    @objc func back() {
        self.delegate?.popViewController()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
