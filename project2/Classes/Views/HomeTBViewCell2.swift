//
//  HomeTBViewCell2.swift
//  project2
//
//  Created by Macintosh on 6/5/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SnapKit

class HomeTBViewCell2: BaseTBCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    //    lazy var title: UILabel = {
//        let title = UILabel()
//        title.text = "test"
//        title.font = .boldSystemFont(ofSize: 20)
//
//        return title
//    }()
//
//    lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView()
//        HomeCLViewCell2.registerCellByClass(collectionView)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.isPagingEnabled = true
//
//        return collectionView
//    }()
//
//    convenience init() {
//        self.init()
//
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//
//        initLayout()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configCLView()
        
    }
    
    func configCLView() {
        HomeCLViewCell2.registerCellByClass(self.collectionView)
    }
    
//    func initLayout(){
//        self.addSubview(title)
//        self.addSubview(collectionView)
//        setTitleLayout()
//        setCollectionViewLayout()
//
//    }
//
//
//    func setTitleLayout() {
//        self.title.snp.makeConstraints { (make) in
//            make.left.equalTo(self)
//            make.top.equalTo(self)
//            make.height.equalTo(30)
//        }
//    }
//
//    func setCollectionViewLayout() {
//        self.collectionView.snp.makeConstraints { (make) in
//            make.left.right.equalTo(self)
//            make.top.equalTo(title.snp.bottom).offset(5)
//            make.bottom.equalTo(self)
//        }
//    }
    
}


extension HomeTBViewCell2: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH - 10, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = HomeCLViewCell2.loadCell(collectionView, path: indexPath) as? HomeCLViewCell2 else{
            return BaseCLCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
