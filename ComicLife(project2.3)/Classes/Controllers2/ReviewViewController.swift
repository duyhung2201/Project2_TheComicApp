//
//  ReviewView.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/10/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit



class ReviewViewController: UIViewController {
    var id_comic = 0
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Write Review"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Submit", style: UIBarButtonItem.Style.plain, target: self, action: #selector(submitReview))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.view.addSubview(tableView)
        configTBView()
        setTBVLayout()
    }
    
    func initData(id_comic: Int){
        self.id_comic = id_comic
    }

    @objc func submitReview() {
        let ratingPoint = (tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! RatingReviewTBViewCell).rating.rating
        let review = (tableView.cellForRow(at: IndexPath(row: 1, section: 0) ) as! WriteReviewTBViewCell).reviewTxv.text
        
        if (review?.isEmpty)! {
            RealmManager.shared.addRating(id_comic: self.id_comic, rating_point: Int(ratingPoint))
        }else {
            RealmManager.shared.addReview(id_comic: self.id_comic, comment: review!, ratingPoint: Int(ratingPoint))
            RealmManager.shared.addRating(id_comic: self.id_comic, rating_point: Int(ratingPoint))
        }
        self.navigationController?.popViewController(animated: true)
    }

    func configTBView() {
        tableView.delegate = self
        tableView.dataSource = self
        RatingReviewTBViewCell.registerCellByClass(tableView)
        WriteReviewTBViewCell.registerCellByClass(tableView)
        
    }
    
    func setTBVLayout() {
        self.tableView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.right.bottom.equalTo(0)
        }
    }
}
extension ReviewViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch indexPath.row {
        case 0:
            guard let cell = RatingReviewTBViewCell.loadCell(tableView) as? RatingReviewTBViewCell else { return BaseTBCell() }
            cell.delegate = self
            return cell
        case 1:
            guard let cell = WriteReviewTBViewCell.loadCell(tableView) as? WriteReviewTBViewCell else { return BaseTBCell() }
            
            return cell
        default:
            return BaseTBCell()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}

extension ReviewViewController: SubmitDelegate {
    func enableSubmit() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
}
