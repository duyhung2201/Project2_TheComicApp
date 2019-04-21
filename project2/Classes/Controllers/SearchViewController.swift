//
//  SearchViewController.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var searchResults = SearchModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Comic"
        self.tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Networking
    func getData(url: String, param: [String : String]) {
        Alamofire.request(url, method: .get, parameters: param).responseJSON{ response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                self.searchResults = SearchModel.init(json: json)
                
                self.tableView.reloadData()
            }
            else{
                print(response.result.error!)
            }
        }
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.title.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = searchResults.title[indexPath.row]
        return cell
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let infoVC = InfoVC()
            infoVC.urlComic = searchResults.url[indexPath.row]
            self.navigationController?.pushViewController(infoVC, animated: true)
        }
}
extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if isFiltering(){
            let parameters: [String : String] = ["q" : searchController.searchBar.text!]
            getData(url: "\(hostUrl)comics/search", param: parameters)
            
        }
    }
}
