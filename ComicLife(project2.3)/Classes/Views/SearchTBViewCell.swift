//
//  LineInfoComicTBViewCell.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class SearchTBViewCell: BaseTBCell {
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 14)
        
        return title
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(title)
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initData(title: String){
        self.title.attributedText = setTitle(title: title)
        
    }
    
    func setTitle(title: String) -> NSAttributedString{
        let icon = NSTextAttachment()
        icon.image = UIImage(named: "search_icon")
        let attIcon = NSAttributedString(attachment: icon)
        let attText = NSAttributedString(string: "  \(title)")
        let text = NSMutableAttributedString()
        text.append(attIcon)
        text.append(attText)
        
        return text
    }
    
    func initLayout() {
        self.title.snp.makeConstraints { (make) in
            make.left.equalTo(MARGIN20)
             make.right.equalTo(-MARGIN20)
            make.top.equalTo(MARGIN7)
            make.bottom.equalTo(-MARGIN7)
        }
       
    }
}
