//
//  HomeTBViewCell3.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit

protocol BaseTBViewCellDelegate {
    func pushVCToComic(id_comic: Int)
    func pushVCToAllComic(title: String, data: [HomeModel])
}

class HomeTBViewCell: BaseTBCell {
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
    
    var delegate : BaseTBViewCellDelegate?
    var imgHeight = 0
    var data = [HomeModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCLView()
        self.contentView.addSubview(titleLbl)
        self.contentView.addSubview(collectionView)
        self.contentView.addSubview(seeAllLbl)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func tapSeeAll() {
       delegate?.pushVCToAllComic(title: self.titleLbl.text!, data: data)
    }
    
    func initData(imgHeight: Int,title: String, data: [HomeModel]) {
        self.titleLbl.text = title
        self.data = data
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
            make.left.top.equalTo(MARGIN)
        }
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(titleLbl.snp.bottom).offset(MARGIN)
            make.right.equalTo(0)
            make.bottom.equalTo(-MARGIN)
            make.height.equalTo(self.imgHeight)
        }
        self.seeAllLbl.snp.makeConstraints { (make) in
            make.right.equalTo(-MARGIN)
            make.centerY.equalTo(titleLbl)
        }
    }
}

extension HomeTBViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH - 50, height: CGFloat(imgHeight))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = HomeCLViewCell.loadCell(self.collectionView, path: indexPath) as? HomeCLViewCell else{
            return BaseCLCell()
        }
        cell.initData(imgHeight: self.imgHeight, data: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: MARGIN, bottom: 0, right: MARGIN)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushVCToComic(id_comic: data[indexPath.row].id)
    }
}

