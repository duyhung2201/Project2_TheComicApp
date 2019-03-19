//
//  IssueReading.swift
//  project2
//
//  Created by Macintosh on 3/17/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import Alamofire

class IssueReading: UIViewController {
    var idIssue: String = "1203_20"
    var pageView = UIPageViewController()
    var issueModel = IssueModel()
    @IBOutlet weak var pageControl: UIPageControl!
    let HOST_URL = "https://mbcomic-app.herokuapp.com/comics/issue"
    var numPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let param = ["id" : idIssue]
        getData(url: HOST_URL, param: param)
        pageView.dataSource = self
        pageView.view.frame = self.view.bounds
        
        
        
        let initialVC = self.vcAtIndex(index: 0)
        let viewControllers: [PageReading] = [initialVC]

        pageView.setViewControllers(viewControllers, direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        self.view.addSubview(pageView.view)
        self.view.addSubview(pageControl)
        self.addChild(pageView)
        self.pageView.didMove(toParent: self)
    }

    //MARK: - Networking
    func getData(url: String, param: [String : String]){
        Alamofire.request(url, method: .get, parameters: param).responseJSON { response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                self.updateIssue(json: json)
                
                DispatchQueue.main.async {
                    self.pageView.reloadInputViews()
                }
            }
            else{
                print(response.result.error!)
            }
        }
    }
    
    //MARK: - JSON Parsing
    func updateIssue(json: JSON) {
        self.issueModel.title = json["title"].stringValue
        
        numPages = json["img"].count
        for i in 0...numPages - 1 {
            self.issueModel.img.append(json["img"][i].stringValue)
            
            print("\(i): \(self.issueModel.img[i])")
        }
        
        self.pageControl.numberOfPages = numPages
    }
    
    //MARK: - UpdatePage
    func vcAtIndex(index: Int) -> PageReading {
        let pageReading = PageReading()
        pageReading.index = index
        pageReading.urlImg = self.issueModel.img[index]
        self.pageControl.currentPage = index
        return pageReading
    }
}

//MARK: - extension PageVCDataSource
extension IssueReading: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PageReading {
            var index = viewController.index
            
            if index == numPages - 1 {
//                return self.vcAtIndex(index: 0)
                return nil
            }
            index += 1
            
            return self.vcAtIndex(index: index)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PageReading {
            var index = viewController.index
            if index == 0 {
//                return self.vcAtIndex(index: numPages - 1)
                return nil
            }
            
            index += -1
            
            return self.vcAtIndex(index: index)
        }
        return nil
    }
}

