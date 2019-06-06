//
//  AllCateViewController.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

//import UIKit
//
//class AllCateViewController: UIViewController {
//
//    lazy var tableView : UITableView = {
//        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        return tableView
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//    }
//}
//
//extension AllCateViewController : UITableViewDelegate , UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        return <#UITableViewCell#>
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return <#CGFloat#>
//    }
//    
//    //cần deligate
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return <#CGFloat#>
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}
