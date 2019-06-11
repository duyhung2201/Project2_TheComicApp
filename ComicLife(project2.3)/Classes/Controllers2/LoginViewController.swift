//
//  LoginView.swift
//  project2
//
//  Created by Macintosh on 5/27/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import Cosmos

class LoginViewController: UIViewController {
//    let realm = try! Realm()
    let placeholderAtts = [
        NSAttributedString.Key.foregroundColor: UIColor.gray,
        NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17)
    ]
    
    lazy var imgView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "Logo2-178x170"))
        return imgView
    }()
    
    lazy var idTxf: BaseTxf = {
        let idTxf = BaseTxf()
        idTxf.attributedPlaceholder = NSAttributedString(string: "Email or Username", attributes: placeholderAtts)
        idTxf.addTarget(self, action: #selector(txfEditBegin(_:)), for: .editingDidBegin)
        idTxf.addTarget(self, action: #selector(txfEditEnd(_:)), for: .editingDidEnd)
        idTxf.backgroundColor = #colorLiteral(red: 0.9060392833, green: 0.9060392833, blue: 0.9060392833, alpha: 1)
        idTxf.layer.cornerRadius = 15
        idTxf.layer.masksToBounds = true
        idTxf.layer.borderWidth = 0
        
        return idTxf
    }()
    
    lazy var passwordTxf: BaseTxf = {
        let passwordTxf = BaseTxf()
        passwordTxf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeholderAtts)
        passwordTxf.addTarget(self, action: #selector(txfEditBegin), for: .editingDidBegin)
        passwordTxf.addTarget(self, action: #selector(txfEditEnd), for: .editingDidEnd)
        passwordTxf.backgroundColor = #colorLiteral(red: 0.9060392833, green: 0.9060392833, blue: 0.9060392833, alpha: 1)
        passwordTxf.layer.cornerRadius = 15
        passwordTxf.layer.masksToBounds = true
        passwordTxf.layer.borderWidth = 0
        
        passwordTxf.isSecureTextEntry = true
        return passwordTxf
    }()
    
    lazy var signinBtn : UILabel = {
        let signinBtn = UILabel()
        signinBtn.text = "Signin"
        signinBtn.textAlignment = .center
        signinBtn.font = UIFont.boldSystemFont(ofSize: 17)
        signinBtn.textColor = .white
        signinBtn.backgroundColor = #colorLiteral(red: 0.1301730486, green: 0.3706113673, blue: 0.5702153928, alpha: 1)
        signinBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSignin))
        signinBtn.addGestureRecognizer(tap)
        signinBtn.layer.cornerRadius = 15
        signinBtn.layer.masksToBounds = true
        signinBtn.layer.borderWidth = 1
        
        return signinBtn
    }()
    
    lazy var desLbl : UILabel = {
        let desLbl = UILabel()
        desLbl.text = "or new to Comic Life ?  "
        desLbl.textColor = .lightGray
        desLbl.font = UIFont.italicSystemFont(ofSize: 13)
        
        return desLbl
    }()
    
    lazy var signupBtn : UILabel = {
        let signupBtn = UILabel()
        signupBtn.text = "Signup"
        signupBtn.textColor = #colorLiteral(red: 0.1301730486, green: 0.3706113673, blue: 0.5702153928, alpha: 1)
        signupBtn.font = UIFont.boldSystemFont(ofSize: 13)
        signupBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSignup))
        signupBtn.addGestureRecognizer(tap)
        
        return signupBtn
    }()
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()

    }
    
    func setRealm(username: String) {
        var config = Realm.Configuration()

        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(username).realm")

        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config

        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    func initLayout() {
        self.title = "Signin"
        self.view.addSubview(idTxf)
        self.view.addSubview(passwordTxf)
        self.view.addSubview(imgView)
        self.view.addSubview(signinBtn)
        self.view.addSubview(desLbl)
        self.view.addSubview(signupBtn)
        setImgViewLayout()
        setIdTxfLayout()
        setPasswordTxfLayout()
        setSigninBtnLayout()
        setDesLblLayout()
        setSinupBtnLayout()
    }
        
    
    func setImgViewLayout() {
        self.imgView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(self.view.frame.width/2)
        }
    }
    
    func setIdTxfLayout() {
        self.idTxf.snp.makeConstraints { (make) in
            make.top.equalTo(imgView.snp.bottom).offset(50)
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.height.equalTo(40)
        }
        
    }
    
    func setPasswordTxfLayout() {
        self.passwordTxf.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.top.equalTo(idTxf.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
    }
    
    func setSigninBtnLayout() {
        self.signinBtn.snp.makeConstraints { (make) in
            make.left.equalTo(idTxf.snp.left)
            make.top.equalTo(passwordTxf.snp.bottom).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(90)
        }
    }
    
    func setDesLblLayout() {
        self.desLbl.snp.makeConstraints { (make) in
            make.right.equalTo(signupBtn.snp.left)
            make.centerY.equalTo(signinBtn)
            make.width.greaterThanOrEqualTo(10)
            make.height.equalTo(30)
        }
    }
    
    func setSinupBtnLayout() {
        self.signupBtn.snp.makeConstraints { (make) in
            make.right.equalTo(passwordTxf.snp.right)
            make.centerY.equalTo(signinBtn)
            make.width.greaterThanOrEqualTo(10)
            make.height.equalTo(30)
        }
    }
    
    @objc func txfEditBegin(_ txf: BaseTxf) {
        txf.layer.borderColor = #colorLiteral(red: 0.1301730486, green: 0.3706113673, blue: 0.5702153928, alpha: 1)
        txf.layer.borderWidth = 1.5
    }
    @objc func txfEditEnd(_ txf: BaseTxf) {
        txf.layer.borderColor = #colorLiteral(red: 0.9060392833, green: 0.9060392833, blue: 0.9060392833, alpha: 1)
        txf.layer.borderWidth = 0
    }
    
    @objc func tapSignin() {
        let realm = try! Realm()
      
        idTxf.attributedPlaceholder = NSAttributedString(string: "Email or Username", attributes: placeholderAtts)
        passwordTxf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeholderAtts)
        if (!(idTxf.text?.isEmpty)! && !(idTxf.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            !(passwordTxf.text?.isEmpty)! && !(passwordTxf.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){

            guard let user = realm.objects(User.self).filter("id = '\(idTxf.text!)'").first else {
                idTxf.text = ""
                passwordTxf.text = ""
                idTxf.attributedPlaceholder = NSAttributedString(string: "Id is wrong", attributes: placeholderAtts)
                return
            }
            if(passwordTxf.text! == user.password) {
                UserDefaults.standard.set(idTxf.text! as String, forKey: USER_KEY)
                RealmManager.shared.user = user
                
                
                self.navigationController?.pushViewController(setHomeTabbarVC(), animated: true)
            }else {
                passwordTxf.text = ""
                passwordTxf.attributedPlaceholder = NSAttributedString(string: "Password is wrong", attributes: placeholderAtts)
            }
        }
    }
    
    @objc func tapSignup() {
        let signupVC = SignupViewController()
        signupVC.id = { (id) in
            self.idTxf.text = id
        }
        self.navigationController?.pushViewController(signupVC, animated: false)
    }
    
    func setHomeTabbarVC() -> UITabBarController {
        let tabbarVC = UITabBarController()
        tabbarVC.navigationController?.navigationBar.isHidden = true
        let naviHome = UINavigationController(rootViewController: HomeViewController())
        naviHome.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
        
        let lstFvr = LstComicViewController()
        lstFvr.getSuggestData(idArr: RealmManager.shared.user.getIdFvr())
        let naviFvr = UINavigationController(rootViewController: lstFvr)
        lstFvr.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        let lstRecent = LstComicViewController()
        lstRecent.getSuggestData(idArr: RealmManager.shared.user.getIdRecent())
        let naviRecent = UINavigationController(rootViewController: lstRecent)
        naviRecent.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 3)
        
        let naviSearch = UINavigationController(rootViewController: SearchViewController())
        naviSearch.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 4)
        
        tabbarVC.viewControllers = [naviHome, naviFvr, naviRecent ,naviSearch]
        
        return tabbarVC
    }
}

