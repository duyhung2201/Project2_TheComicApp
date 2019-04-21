//
//  ViewController.swift
//  project2
//
//  Created by Macintosh on 3/15/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var imgComic: UIImageView!
    @IBOutlet weak var infoComic: UILabel!
    @IBOutlet weak var summaryComic: UILabel!
    
    let HOST_URL = "https://mbcomic-app.herokuapp.com"
    var in4ComicModel = In4ComicModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let parameters: [String : String] = ["slug" : "/the-walking-dead"]
        getData(url: HOST_URL, param: parameters)
    }
    
    //MARK: - Networking
    func getData(url: String, param: [String : String]) {
        Alamofire.request(url, method: .get, parameters: param).responseJSON{ response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                self.updateIn4Comic(json: json)
                self.updateUIView()
            }
            else{
                print(response.result.error)
            }
        }
    }
    
    //MARK: - JSON Parsing
    func updateIn4Comic(json: JSON) {
        in4ComicModel.author = json["author"].stringValue
//        print(in4ComicModel.author)
        in4ComicModel.genre = json["genre"].stringValue
        in4ComicModel.image = json["cover"].stringValue
        in4ComicModel.number_issues = json["number_issues"].intValue
        in4ComicModel.publisher = json["publisher"].stringValue
        in4ComicModel.title = json["title"].stringValue
        in4ComicModel.status = json["status"].stringValue
        in4ComicModel.year = json["year"].intValue
        in4ComicModel.summary = json["summary"].stringValue
        
    }
    
    //MARK: - updateUI
    func updateUIView() {
        infoComic.text = "Author: \(in4ComicModel.author) \nGenre: \(in4ComicModel.genre)\n"
        summaryComic.text = in4ComicModel.summary
        imgComic.image = UIImage.init(named: in4ComicModel.image)
    }
        
    
}
