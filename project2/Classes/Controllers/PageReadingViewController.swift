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
    @IBOutlet weak var indexLb: UILabel!
    @IBOutlet weak var imgPage: UIImageView!
    
    var index: Int = 0
    
    var urlImg: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        indexLb.text = "Page \(1 + index)"       
        imgPage.kf.setImage(with: URL(string: urlImg.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!), options: [.requestModifier(modifier)])

    }
    
}
