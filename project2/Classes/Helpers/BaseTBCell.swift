//
//  BaseTBCell.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class BaseTBCell: UITableViewCell {
    
    //MARK: define for cell
    static func identifier() -> String {
        return String(describing: self.self)
    }
    
    static func height() -> CGFloat {
        return 0
    }
    
    static func registerCellByClass(_ tableView: UITableView) {
        tableView.register(self.self, forCellReuseIdentifier: self.identifier())
    }
    
    static func registerCellByNib(_ tableView: UITableView) {
        let nib = UINib(nibName: self.identifier(), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.identifier())
    }
    
    static func loadCell(_ tableView: UITableView) -> BaseTBCell {
        return tableView.dequeueReusableCell(withIdentifier: self.identifier()) as! BaseTBCell
    }
}
