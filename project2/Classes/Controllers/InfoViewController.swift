//
//  ViewController.swift
//  project2
//
//  Created by Macintosh on 3/15/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import iOSDropDown
import SnapKit
import SwiftyJSON
import RealmSwift
import Cosmos

class InfoViewController: UIViewController {
    
    @IBOutlet weak var imgComic: UIImageView!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var titleComic: UILabel!
    @IBOutlet weak var issueBox: DropDown!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var SummaryView: UIView!
    @IBOutlet weak var selectLb: UILabel!
    @IBOutlet weak var similarLb: UILabel!
    @IBOutlet weak var issueBoxView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var similarCol: UICollectionView!
    @IBOutlet weak var favBut: UIButton!
    @IBOutlet weak var reviewBut: UIButton!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    
    var infoComicModel = InfoComicModel() {
        didSet{
            setSimilarCol()
            pressFavTag = realm.objects(FavoriteComicModel.self).filter{ $0.url == self.infoComicModel.url }.count == 0 ? 0:1
            self.updateUIView()
        }
    }
    lazy var alert : UIAlertController = {
        let alert = UIAlertController(title: "Enjoy this comic ?", message: "Tap a star to rate this comic \n\n\n", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancle", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertAction.Style.default, handler: nil))
        
        return alert
    }()
    
    var urlComic: String = ""
    var rowPicked: Int = 0
    let loadView = sharedLoadView
    var similarComicModel = [SimilarComicModel]() {
        didSet{
            self.similarCol.reloadData()
        }
    }
    var selectLbUnderLine = CALayer()
    var similarLbUnderLine = CALayer()
    let realm = try! Realm()
    var pressFavTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView.frame = UIScreen.main.bounds
        self.view.addSubview(self.loadView)
        self.tabBarController?.tabBar.isHidden = true
        
        let parameters: [String : String] = ["slug" : urlComic]
        getComicData(url: "\(hostUrl)comics", param: parameters)
        
        similarCol.delegate = self
        similarCol.dataSource = self
        similarCol.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    func setRatingView() {
        var options = CosmosSettings()
        options.updateOnTouch = true
        options.starSize = 30
        options.fillMode = .precise
        options.starMargin = 5
        options.filledColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        options.emptyBorderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        options.filledBorderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)

        let cosmosView = CosmosView(settings: options)
        alert.view.addSubview(cosmosView)
        cosmosView.snp.makeConstraints { (make) in
            make.bottom.equalTo(alert.view.snp.bottom).offset(-60)
            make.centerX.equalTo(alert.view.snp.centerX)
        }
    }
    
    @IBAction func tapReview(_ sender: Any) {
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Networking
    func getComicData(url: String, param: [String : String]) {
        Alamofire.request(url, method: .get, parameters: param).responseJSON{ response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                self.infoComicModel = InfoComicModel.init(json: json)
                
            }
            else{
                print(response.result.error!)
            }
        }
    }
    
    @IBAction func pushToIssue(_ sender: Any) {
        if(self.issueBox.text != ""){
            let issueReading = IssueReading()
            issueReading.idIssue = infoComicModel.issues[rowPicked].id
            self.navigationController?.pushViewController(issueReading, animated: false)
        }
        else{
            presentAlert(title: "Error", description: "You must select an issue!")
        }
    }
    func presentAlert(title: String, description: String){
        let alertController = UIAlertController(title: title,
                                                message: description,
                                                preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .destructive) { alert in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(alertAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func pressFav(_ sender: Any) {
        
        if(pressFavTag == 0){
            try! realm.write {
                let favComic = FavoriteComicModel.init(infoComicModel: self.infoComicModel)
                realm.add(favComic)
            }
            pressFavTag = 1
            self.favBut.setTitle("❤️ Like", for: .normal)
            favBut.tintColor = .red
        }
        else{
            try! realm.write {
                realm.delete(realm.objects(FavoriteComicModel.self).filter{ $0.url == self.infoComicModel.url })
            }
            pressFavTag = 0
            self.favBut.setTitle("♡ Like", for: .normal)
            favBut.tintColor = .black
        }
    }
}

extension InfoViewController {
    func updateUIView() {
        self.title = infoComicModel.title
        setSubTitle()
        setInfo()
        self.titleComic.attributedText = setTitle(title: infoComicModel.title, subTitle: " #\(infoComicModel.number_issues) issues")
        setFrameView(yourView: SummaryView)
        summary.text = "'\(infoComicModel.summary)'"
        setImgComic()
        setFavBut()
        setIssueBox()
        setBottomLine()
        setSelectLb()
        setSimilarLb()
        underlineSelectLb()
        setRatingView()
        self.loadView.removeFromSuperview()
    }
    
    func setImgComic() {
        imgComic.kf.setImage(with: URL(string: infoComicModel.image), options: [.requestModifier(modifier)])
        imgComic.layer.cornerRadius = 10
        imgComic.layer.masksToBounds = true
    }
    func setIssueBox() {
        for i in infoComicModel.issues {
            self.issueBox.optionArray.append(i.title)
        }
        self.issueBox.placeholder = "Select issue"
        self.issueBox.cornerRadius = 10
        self.issueBox.selectedRowColor = .lightGray
        self.issueBox.didSelect{(selectedText, index, id) in
            self.rowPicked = index
        }
    }
    
    func setInfo() {
        let s0 = NSMutableAttributedString(string: "")
        let s1 = setInfoCell(str1: "•Publisher: ", str2: infoComicModel.publisher)
        let s2 = setInfoCell(str1: "\n\n•Author: ", str2: infoComicModel.author)
        let s3 = setInfoCell(str1: "\n\n•Status: ", str2: infoComicModel.status)
        s0.append(s1)
        s0.append(s2)
        s0.append(s3)
        self.info.attributedText = s0
    }
    func setSubTitle(){
        let fullString = NSMutableAttributedString(string: "\(infoComicModel.year) | ")
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        image1Attachment.image = UIImage(named: "tag_icon20x20")
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: infoComicModel.genre))
        
        subTitle.attributedText = fullString
    }
    
    func setInfoCell(str1: String, str2: String) -> NSAttributedString{
        let style1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 1)), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let style2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]
        let attributedText = NSMutableAttributedString(string: str1, attributes: style1)
        attributedText.append(NSAttributedString(string: str2, attributes: style2))
        return attributedText
    }
    
    func setFavBut(){
        setFrameView(yourView: favBut)
        setFrameView(yourView: reviewBut)
        if (pressFavTag == 0){
            self.favBut.setTitle("♡ Like", for: .normal)
            favBut.tintColor = .black
        }
        else{
            self.favBut.setTitle("❤️ Like", for: .normal)
            favBut.tintColor = .red
        }
    }
    
    func setTitle(title: String, subTitle: String) -> NSAttributedString{
        let style1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 30, weight: UIFont.Weight(rawValue: 10)), NSAttributedString.Key.foregroundColor: UIColor.red]
        let attributedText = NSMutableAttributedString(string: title, attributes: style1)
        attributedText.append(NSAttributedString(string: subTitle, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: UIFont.Weight(rawValue: 1))]))
        return attributedText
    }
    
    func setFrameView(yourView: UIView) {
        yourView.layer.borderWidth = 1
        yourView.layer.borderColor = UIColor.gray.cgColor
        yourView.layer.cornerRadius = 10
        yourView.layer.masksToBounds = true
    }
    func setBottomLine(){
        selectLbUnderLine.frame = CGRect(x: 0.0, y: selectLb.frame.height, width: selectLb.frame.width, height: 1.0)
        selectLbUnderLine.backgroundColor = UIColor.black.cgColor
        selectLb.layer.addSublayer(selectLbUnderLine)
        
        similarLbUnderLine.frame = CGRect(x: 0.0, y: similarLb.frame.height, width: similarLb.frame.width, height: 1.0)
        similarLbUnderLine.backgroundColor = UIColor.black.cgColor
        similarLb.layer.addSublayer(similarLbUnderLine)
    }
    
    func setSelectLb() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(underlineSelectLb))
        self.selectLb.isUserInteractionEnabled = true
        self.selectLb.addGestureRecognizer(tap)
    }
    func setSimilarLb() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(underlineSimilarLb))
        self.similarLb.isUserInteractionEnabled = true
        self.similarLb.addGestureRecognizer(tap)
    }
    @objc func underlineSelectLb() {
        selectLb.layer.addSublayer(selectLbUnderLine)
        selectLb.textColor = .darkGray
        similarLbUnderLine.removeFromSuperlayer()
        similarLb.textColor = UIColor.lightGray
        self.issueBoxView.isHidden = false
        self.similarCol.isHidden = true
    }
    
    @objc func underlineSimilarLb() {
        self.similarLb.layer.addSublayer(similarLbUnderLine)
        similarLb.textColor = .darkGray
        selectLbUnderLine.removeFromSuperlayer()
        selectLb.textColor = .lightGray
        self.similarCol.isHidden = false
        self.issueBoxView.isHidden = true
        
    }

    
    func setSimilarCol() {
        self.similarCol.snp.makeConstraints {(make) in
            make.width.equalTo(SCREEN_WIDTH - 10)
            make.height.equalTo(COL_CELL_HEIGHT + 10)
            make.left.equalTo(contentView).offset(5)
            make.top.equalTo(selectLb.snp.bottom).offset(20)
        }

        contentView.addSubview(similarCol)
        similarCol.isHidden = true
        let parameters: [String : String] = ["id" : infoComicModel.id]
        getSimilarData(url: "\(hostUrl)comics/similar", param: parameters)
    }
    
    //MARK: - Networking
    func getSimilarData(url: String, param: [String : String]) {
        Alamofire.request(url, method: .get, parameters: param).responseJSON{ response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                for i in 1...json.count - 1 {
                    self.similarComicModel.append(SimilarComicModel.init(json: json[i]))
                }
            }
            else{
                print(response.result.error!)
            }
        }
    }
}

extension InfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: COL_CELL_WIDTH, height: COL_CELL_HEIGHT)
    }
}

extension InfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarComicModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeCollectionViewCell
        cell.similarData = self.similarComicModel[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let infoVC = InfoViewController()
        infoVC.urlComic = similarComicModel[indexPath.row].url
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
}
