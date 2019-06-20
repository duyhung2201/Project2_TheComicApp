//
//  ComicViewController.swift
//  project2
//
//  Created by Macintosh on 6/6/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import RealmSwift

class ComicViewController: UIViewController{
    var id_comic : Int?
    var data : InfoComicModel? {
        didSet {
            self.title = self.data!.title
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.configTBView()
        }
    }
    var fvrState = false
    var fvrCount = 0
    var ratingPoint = 0.0
    var ratingCount = 0
    var reviews = List<Review>()
    
    
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
        self.view.addSubview(tableView)
        setTBVLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.tabBarController?.tabBar.isHidden = false
        updateRealmData(id_comic: self.id_comic!)
        DispatchQueue.main.async {
            self.tableView.beginUpdates()
            self.tableView.reloadData()
            (self.tableView.cellForRow(at: IndexPath(row: 2, section: 0) ) as? ReviewTBViewCell)?.collectionView.reloadData()
            (self.tableView.cellForRow(at: IndexPath(row: 4, section: 0) ) as? HomeTBViewCell)?.collectionView.reloadData()
            self.tableView.endUpdates()
        }
    }
    
    func initData(id_comic: Int){
        self.id_comic = id_comic
        getData(id_comic: id_comic)
    }
    
    func updateRealmData(id_comic:Int) {
        let realmData = RealmManager.shared.getRealmComicData(id_comic: id_comic)
        self.ratingPoint = realmData[RealmComicTypeData.ratingPoint.rawValue] as! Double
        self.ratingCount = realmData[RealmComicTypeData.ratingCount.rawValue] as! Int
        self.fvrCount = realmData[RealmComicTypeData.fvrCount.rawValue] as! Int
        self.fvrState = realmData[RealmComicTypeData.fvrState.rawValue] as! Bool
        self.reviews = realmData[RealmComicTypeData.reviews.rawValue] as! List<Review>
    }
    
    func configTBView() {
        tableView.delegate = self
        tableView.dataSource = self
        TopComicTBViewCell.registerCellByClass(tableView)
        SecondComicTBViewCell.registerCellByClass(tableView)
        SummaryComicTBViewCell.registerCellByClass(tableView)
        InfoComicTBViewCell.registerCellByClass(tableView)
        HomeTBViewCell.registerCellByClass(tableView)
        ReviewTBViewCell.registerCellByClass(tableView)
    }

    func getData(id_comic: Int) {
        ComicApiManage.shared.getComicById(id_comic: self.id_comic!) { (success, data) in
            if success {
                self.data = data as? InfoComicModel
                
            }
        }
    }

    func getInfoTBData(data: InfoComicModel) -> [LineInfoComicModel]{
        var infoTBData = [LineInfoComicModel]()
        infoTBData.append(LineInfoComicModel(title: "Author", detail: (data.author)))
        infoTBData.append(LineInfoComicModel(title: "Category", detail: (data.genre)))
        infoTBData.append(LineInfoComicModel(title: "Publisher", detail: (data.publisher)))
        infoTBData.append(LineInfoComicModel(title: "Year", detail: (data.year)))
        infoTBData.append(LineInfoComicModel(title: "Status", detail: (data.status)))
        infoTBData.append(LineInfoComicModel(title: "Number of chapter  ", detail: "\((data.number_issues) - 1)"))
        infoTBData.append(LineInfoComicModel(title: "Contact us", detail: "+84 902125230"))
        
        return infoTBData
    }
    
    func setTBVLayout() {
        self.tableView.snp.makeConstraints { (make) in
            make.left.top.equalTo(0)
            make.right.bottom.equalTo(0)
        }
    }
}


extension ComicViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        switch indexPath.row {
//        case 0:
//            guard let cell = TopComicTBViewCell.loadCell(tableView) as? TopComicTBViewCell else { return BaseTBCell() }
//            cell.initData(imgHeight: COL_CELL_HEIGHT,
//                          id_comic: (self.data!.id),
//                          imgUrl: (self.data!.image),
//                          title: (self.data!.title),
//                          sub_title: (self.data!.publisher),
//                          fvrState: self.fvrState)
//            cell.delegate = self
//
//            return cell
//        case 1:
//            guard let cell = SecondComicTBViewCell.loadCell(tableView) as? SecondComicTBViewCell else {return BaseTBCell()}
//            cell.initData(ratingCount: self.ratingCount, ratingPoint: self.ratingPoint, fvrCount: self.fvrCount, reviewCount: self.reviews.count)
//
//            return cell
//        case 2:
//            guard let cell = SummaryComicTBViewCell.loadCell(tableView) as? SummaryComicTBViewCell else { return BaseTBCell() }
//            cell.initData(title: "Summary", summary: (self.data!.summary))
//
//            return cell
        case 0:
            guard let cell = ReviewTBViewCell.loadCell(tableView) as? ReviewTBViewCell else { return BaseTBCell() }
            cell.initData(id_comic: self.id_comic! ,height: COL_CELL_HEIGHT2, title: "Review", data: self.reviews)
            cell.delegate = self

            return cell
        case 1:
            guard let cell = InfoComicTBViewCell.loadCell(tableView) as? InfoComicTBViewCell else { return BaseTBCell() }
            cell.initData(title: "Infomation", data: getInfoTBData(data: data!))

            return cell
//        case 5:
//            guard let cell = HomeTBViewCell.loadCell(tableView) as? HomeTBViewCell else { return BaseTBCell() }
//            var similarData = self.data!.similars
//            similarData.removeFirst()
//            cell.initData(imgHeight: COL_CELL_HEIGHT2, title: "You May Also Like", data: similarData)
//            cell.delegate = self
//            cell.separatorInset = UIEdgeInsets(top: 0, left: SCREEN_WIDTH, bottom: 0, right: 0)
//
//            return cell
        default:
            return BaseTBCell()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (tableView.indexPathsForVisibleRows?.contains(IndexPath(row: 0, section: 0)))! {
            self.title = ""
        }else {
            self.title = self.data?.title
        }
    }
}

extension ComicViewController: HomeTBCellDelegate {
    func pushVCToComic(id_comic: Int) {
        let vc = ComicViewController()
        vc.initData(id_comic: id_comic)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushVCToAllComic(title: String, data: [HomeModel]) {
        let vc = LstComicViewController()
        vc.initData(title: title, data: data)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ComicViewController: ReviewTBCellDelegate {
    func pushVCToLstReview() {
        
    }
    
    func pushVCToWriteReView() {
        let vc = ReviewViewController()
        vc.initData(id_comic: id_comic!)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ComicViewController: TopTBCellDelegate {
    func scrollToReview() {
        self.tableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: UITableView.ScrollPosition.middle, animated: true)
    }
    
    func pushToLstIssue(id_comic: Int) {
        let vc = LstIssueViewController()
        vc.initData(id_comic: id_comic, data: (self.data?.issues)!)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
