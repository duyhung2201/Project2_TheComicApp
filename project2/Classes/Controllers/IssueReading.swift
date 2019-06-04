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

class IssueReading: UIPageViewController {
    var issueModel = IssueModel()
    var pageReading: [PageReadingViewController] = [PageReadingViewController]()
    var idIssue: String = ""
    var pageIndex = 0
    var numPages = 0
    let loadView = sharedLoadView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        loadView.frame = UIScreen.main.bounds
        self.view.addSubview(loadView)
        let param = ["id" : idIssue]
        getData(url: "\(hostUrl)comics/issue", param: param)
        self.dataSource = self
    }
    
    //MARK: - Networking
    func getData(url: String, param: [String : String]){
        Alamofire.request(url, method: .get, parameters: param).responseJSON { response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                self.issueModel = IssueModel.init(json: json)
                self.setPageReading()
            }
            else{
                print(response.result.error!)
            }
        }
    }
}

extension IssueReading {
    func setPageReading() {
        numPages = issueModel.img.count
        
        if numPages == 0 {
            let lable = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
            lable.text = "No Data"
            lable.backgroundColor = .white
            lable.textAlignment = .center
            self.view.addSubview(lable)
        }else{
            for i in 0...numPages - 1{
                let temp = PageReadingViewController()
                temp.index = i
                temp.urlImg = issueModel.img[i]
                self.pageReading.append(temp)
            }
            let urls = issueModel.img.map { URL(string: $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)! }
            let prefetcher = ImagePrefetcher(urls: urls) 
            prefetcher.start()
            self.setViewControllers([self.pageReading[0]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        }
        self.loadView.removeFromSuperview()
    }
}



//MARK: - extension PageVCDataSource
extension IssueReading: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if self.pageIndex == numPages - 1 {
            return nil
        }
        pageIndex += 1
        return self.pageReading[pageIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if self.pageIndex == 0 {
            return nil
        }
        pageIndex -= 1
        return self.pageReading[pageIndex]
    }
}

