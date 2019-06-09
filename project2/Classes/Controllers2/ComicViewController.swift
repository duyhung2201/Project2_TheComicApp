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
    var data : InfoComicModel2?
    var infoTBData = [LineInfoComicModel]()
    var fvrState = false
    var fvrCount = 0
    var ratingPoint = 0.0
    var ratings = List<Rating>()
    var comments = List<Comment>()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorInset = UIEdgeInsets(top: 0, left: MARGIN, bottom: 0, right: MARGIN)
        tableView.tableFooterView = UIView(frame: .zero)

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        setTBVLayout()
    }
    
    func initData(id_comic: Int){
        self.id_comic = id_comic
        let realmData = RealmManager.shared.getRealmComicData(id_comic: id_comic)
        self.ratings = realmData[RealmComicTypeData.ratings.rawValue] as! List<Rating>
        self.ratingPoint = realmData[RealmComicTypeData.ratingPoint.rawValue] as! Double
        self.fvrCount = realmData[RealmComicTypeData.fvrCount.rawValue] as! Int
        self.fvrState = realmData[RealmComicTypeData.fvrState.rawValue] as! Bool
        self.comments = realmData[RealmComicTypeData.comments.rawValue] as! List<Comment>
        getData(id_comic: id_comic)
    }
    
    func configTBView() {
        tableView.delegate = self
        tableView.dataSource = self
        TopComicBViewCell.registerCellByClass(tableView)
        SummaryComicTBViewCell.registerCellByClass(tableView)
        InfoComicTBViewCell.registerCellByClass(tableView)
        HomeTBViewCell.registerCellByClass(tableView)
        
    }

    func getData(id_comic: Int) {
        ComicApiManage.shared.getComicById(id_comic: self.id_comic!) { (success, data) in
            if success {
                self.data = data as? InfoComicModel2
                self.setInfoTBData(data: data as! InfoComicModel2)
                self.title = self.data?.title
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.configTBView()
            }
        }
    }

    func setInfoTBData(data: InfoComicModel2) {
        infoTBData.append(LineInfoComicModel(title: "Author", detail: (data.author)))
        infoTBData.append(LineInfoComicModel(title: "Category", detail: (data.genre)))
        infoTBData.append(LineInfoComicModel(title: "Publisher", detail: (data.publisher)))
        infoTBData.append(LineInfoComicModel(title: "Year", detail: (data.year)))
        infoTBData.append(LineInfoComicModel(title: "Status", detail: (data.status)))
        infoTBData.append(LineInfoComicModel(title: "Number of chapter", detail: "\((data.number_issues) - 1)"))
        infoTBData.append(LineInfoComicModel(title: "Contact us", detail: "+84 902125230"))
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
        case 0:
            guard let cell = TopComicBViewCell.loadCell(tableView) as? TopComicBViewCell else { return BaseTBCell() }
            cell.initData(imgHeight: COL_CELL_HEIGHT,
                          id_comic: (self.data!.id),
                          imgUrl: (self.data!.image),
                          title: (self.data!.title),
                          sub_title: (self.data!.publisher),
                          ratingCount: self.ratings.count,
                          ratingPoint: self.ratingPoint,
                          fvrState: self.fvrState,
                          fvrCount: self.fvrCount,
                          cmtCount: self.comments.count)
            return cell
        case 1:
            guard let cell = SummaryComicTBViewCell.loadCell(tableView) as? SummaryComicTBViewCell else { return BaseTBCell() }
        cell.initData(title: "Summary", summary: (self.data!.summary))

            return cell
        case 2:
            guard let cell = InfoComicTBViewCell.loadCell(tableView) as? InfoComicTBViewCell else { return BaseTBCell() }
            cell.initData(title: "Infomation", data: infoTBData)

            return cell
        case 3:
            guard let cell = HomeTBViewCell.loadCell(tableView) as? HomeTBViewCell else { return BaseTBCell() }
            cell.initData(imgHeight: 141, title: "You May Also Like", data: (self.data!.similars))
            cell.delegate = self
            
            return cell
        default:
            return BaseTBCell()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}
extension ComicViewController: BaseTBViewCellDelegate {
    func pushVCToComic(id_comic: Int) {
        let vc = ComicViewController()
        vc.initData(id_comic: id_comic)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pushVCToAllComic(title: String, data: [HomeModel]) {
        
        let vc = LstComicTBViewController()
        vc.initData(title: title, data: data)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
