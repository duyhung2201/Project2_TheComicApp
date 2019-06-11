//
//  SearchViewController.swift
//  project2
//
//  Created by HoaPQ on 3/11/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController {
    var searchResults = [SearchModel]()
    let searchController = UISearchController(searchResultsController: nil)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        SearchTBViewCell.registerCellByClass(tableView)
        
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.view.addSubview(tableView)
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Comic Life"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        initLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    //MARK: - Networking
    func getData(title: String) {
        let slug = "search?q=\(title)"
        ComicApiManage.shared.getSearchBySlug(slug: slug) { (success, data) in
            if success {
                self.searchResults = data as! [SearchModel]
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return (searchController.searchBar.text?.trimmingCharacters(in: .whitespaces).isEmpty) ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func initLayout() {
        self.tableView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

            return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = SearchTBViewCell.loadCell(tableView) as? SearchTBViewCell else { return BaseTBCell()}
        cell.initData(title: searchResults[indexPath.row].title)
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = ComicViewController()
            vc.initData(id_comic: searchResults[indexPath.row].id)
            self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension SearchViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        if isFiltering(){
            getData(title: searchController.searchBar.text!)
        }
    }
}
