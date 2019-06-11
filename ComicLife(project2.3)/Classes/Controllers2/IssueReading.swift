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

class IssueReading: UIPageViewController {
    var data = IssueModel()
    var pageReading: [PageReadingViewController] = [PageReadingViewController]()
    var idIssue: String = ""
    var pageIndex = 0
    var numPages = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        self.dataSource = self
    }
    
    func initData(id_issue: String){
        getData(id_issue: id_issue)
    }
    //MARK: - Networking
    func getData(id_issue: String){
        ComicApiManage.shared.getIssueById(id: id_issue) { (success, data) in
            if success {
                self.data = data as! IssueModel
                self.setPageReading()
            }
        }
    }
    
}

extension IssueReading {
    func setPageReading() {
        numPages = data.img.count
        
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
                temp.urlImg = data.img[i]
                self.pageReading.append(temp)
            }
            let urls = data.img.map { URL(string: $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)! }
            let prefetcher = ImagePrefetcher(urls: urls) 
            prefetcher.start()
            self.setViewControllers([self.pageReading[0]], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
        }
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

