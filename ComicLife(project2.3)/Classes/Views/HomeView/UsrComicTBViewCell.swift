//
//  UsrComicTBViewCell.swift
//  ComicLife(project2.3)
//
//  Created by Macintosh on 6/19/19.
//  Copyright © 2019 Macintosh. All rights reserved.
//

import UIKit

protocol UsrComicTBViewCellDelegate {
    func pushVCToComic(data: InfoComicModel)
    func pushVCToLstComic(title: String, data: [InfoComicModel])
}

class UsrComicTBViewCell: BaseTBCell {
    var cellIndexPath = 0
    var delegate : UsrComicTBViewCellDelegate?
    var imgHeight = 0
    var data = [InfoComicModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    var idArr = [Int]()
    
    var titleLbl: UILabel = {
        let titleLbl = UILabel()
        titleLbl.font = .boldSystemFont(ofSize: 20)
        
        return titleLbl
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let rect = CGRect(x: CGFloat(0), y:50, width: SCREEN_WIDTH, height: 180)
        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    lazy var seeAllLbl: UILabel = {
        let seeAllLbl = UILabel()
        seeAllLbl.textColor = BLUE_COLOR
        seeAllLbl.font = .systemFont(ofSize: 14)
        seeAllLbl.text = "See All"
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSeeAll))
        seeAllLbl.addGestureRecognizer(tap)
        seeAllLbl.isUserInteractionEnabled = true
        
        return seeAllLbl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCLView()
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(seeAllLbl)
        addGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeRight))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeLeft))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.collectionView.addGestureRecognizer(swipeLeft)
        self.collectionView.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeLeft(){
        if cellIndexPath < data.count - 1  {
            cellIndexPath += 1
            collectionView.scrollToItem(at: IndexPath(item: self.cellIndexPath, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        if cellIndexPath > data.count - 3 {
            loadMoreData()
        }
        
    }
    
    func loadMoreData() {
        if idArr.count > 0 {
            ComicApiManage.shared.getComicById(id_comic: idArr.removeFirst()) { (success, data) in
                if success {
                    self.data.append(data as! InfoComicModel)
                    self.collectionView.insertItems(at: [IndexPath(item: self.data.count - 1, section: 0)])
                }
            }
        }else {
            return
        }
    }
    @objc func swipeRight(){
        if cellIndexPath > 0 {
            cellIndexPath -= 1
            collectionView.scrollToItem(at: IndexPath(item: self.cellIndexPath, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
    }
    
    @objc func tapSeeAll() {
        delegate?.pushVCToLstComic(title: self.titleLbl.text!, data: data)
    }
    
    func initData(imgHeight: Int,title: String, data: [InfoComicModel], idArr: [Int]) {
        self.titleLbl.text = title
        self.data = data
        self.idArr = idArr
        self.imgHeight = imgHeight
        initLayout()
    }
    
    func configCLView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        HomeCLViewCell.registerCellByClass(self.collectionView)
        
    }
    
    func initLayout() {
        self.titleLbl.snp.makeConstraints { (make) in
            make.left.top.equalTo(MARGIN20)
        }
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(titleLbl.snp.bottom).offset(MARGIN20)
            make.right.equalTo(0)
            make.bottom.equalTo(-MARGIN20)
            make.height.equalTo(self.imgHeight)
        }
        self.seeAllLbl.snp.makeConstraints { (make) in
            make.right.equalTo(-MARGIN20)
            make.centerY.equalTo(titleLbl)
        }
    }
}

extension UsrComicTBViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH - 2*MARGIN20, height: CGFloat(imgHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = HomeCLViewCell.loadCell(self.collectionView, path: indexPath) as? HomeCLViewCell else{
            return BaseCLCell()
        }
        
        cell.initData(imgHeight: self.imgHeight, data: data[indexPath.row].similars[0])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: MARGIN20, bottom: 0, right: MARGIN20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushVCToComic(data: self.data[indexPath.item])
    }
    
    
}


