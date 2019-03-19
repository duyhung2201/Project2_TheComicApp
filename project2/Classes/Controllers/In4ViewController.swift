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
import Kingfisher

class In4ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var imgComic: UIImageView!
    @IBOutlet weak var infoComic: UILabel!
    @IBOutlet weak var summaryComic: UILabel!
    @IBOutlet weak var titleComic: UILabel!
    @IBOutlet weak var issueTF: UITextField!
    @IBOutlet weak var dropBoxIssue: UIPickerView!

    @IBAction func readIssue(_ sender: Any) {
        self.navigationController?.pushViewController(IssueReading(), animated: true)
    }
    
    var urlComic: String = ""
    var pickerData = [[String](), [String]()]
    let HOST_URL = "https://mbcomic-app.herokuapp.com/comics"
    var in4ComicModel = In4ComicModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let parameters: [String : String] = ["slug" : urlComic]
        getData(url: HOST_URL, param: parameters)
        dropBoxIssue.delegate = self
        dropBoxIssue.dataSource = self
        
        self.title = in4ComicModel.title
    }
    
    //MARK: - Networking
    func getData(url: String, param: [String : String]) {
        Alamofire.request(url, method: .get, parameters: param).responseJSON{ response in
            
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                self.updateIn4Comic(json: json)
                self.updateUIView()
                
                DispatchQueue.main.async {
                    self.dropBoxIssue.reloadAllComponents()
                }
                
            }
            else{
                print(response.result.error!)
            }
        }
    }
    
    //MARK: - JSON Parsing
    func updateIn4Comic(json: JSON) {
        
        func getDataArray(att: String) -> String {
            let json = json[att]
            var s: String = ""
            for i in 0...json.count-1{
                if i == 0{
                    s += json[0].stringValue
                }else{
                    s += ", \(json[i])"
                }
            }
            return s
        }
        
        in4ComicModel.author = getDataArray(att: "author")
        in4ComicModel.genre = getDataArray(att: "genre")
        in4ComicModel.image = json["cover"].stringValue
        in4ComicModel.number_issues = json["number_issues"].intValue
        in4ComicModel.publisher = json["publisher"].stringValue
        in4ComicModel.title = json["title"].stringValue
        in4ComicModel.status = json["status"].stringValue
        in4ComicModel.year = json["year"].intValue
        in4ComicModel.summary = json["summary"].stringValue
        
        for i in 0...json["issues"].count - 1 {
            pickerData[0].append(json["issues"][i]["title"].stringValue)
            pickerData[1].append(json["issues"][i]["_id"].stringValue)
        }
    }
    
    //MARK: - updateUI
    func updateUIView() {
        titleComic.text = in4ComicModel.title
        titleComic.textColor = .red
        
        infoComic.text = "- Genre: \(in4ComicModel.genre)\n- Author: \(in4ComicModel.author)\n Publisher: \(in4ComicModel.publisher)\n- Status: \(in4ComicModel.status)\n"
        summaryComic.text = "   Summary: \(in4ComicModel.summary)"
        imgComic.kf.setImage(with: URL(string: in4ComicModel.image))
    }
    
    //MARK - PickerViewDelegate, DataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[0].count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[0][row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        issueTF.text = pickerData[0][row]
        dropBoxIssue.isHidden = true
//        dropDownIcon.isHidden = false
    }
    @IBAction func touchTF(_ sender: Any) {
        dropBoxIssue.isHidden = false
    }
}
