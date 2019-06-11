//
//  LineInfoComicModel.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

class LineInfoComicModel: NSObject {
    var title = ""
    var detail = ""
    
    convenience init(title: String, detail: String) {
        self.init()
        self.title = title
        self.detail = detail
    }
}
