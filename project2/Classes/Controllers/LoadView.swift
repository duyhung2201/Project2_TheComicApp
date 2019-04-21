//
//  LoadView.swift
//  
//
//  Created by Macintosh on 3/24/19.
//

import UIKit
import FLAnimatedImage

class LoadView: UIView {
    @IBOutlet weak var gifImg: FLAnimatedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateGif()
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "LoadView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func updateGif() {
        let path1 : String = Bundle.main.path(forResource: "superman", ofType: "gif")!
        let url = URL(fileURLWithPath: path1)
        let gifData = try? Data(contentsOf: url)
        let imageData1 = FLAnimatedImage(animatedGIFData: gifData)
        gifImg.animatedImage = imageData1
    }
}
