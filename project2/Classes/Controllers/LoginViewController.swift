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
        setRealm(username: "Project2.1")
        initLayout()
        
//        let frame = CGRect(x: 5, y: 100, width: self.view.frame.width - 10, height: 150)
//        let imgComicView = ImgComicView(imgUrl: "https://comicpunch.net/pics3/seaoflove03.jpg", title: "Fantastic Four (2018)", issue_name: "issue # 100", rating_star: 0, ratingCount: 0, frame: frame)
//
//        self.view.addSubview(imgComicView)

    }
    
    func setRealm(username: String) {
        var config = Realm.Configuration()

        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(username).realm")

        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
//
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
//        let tabbarVC = UITabBarController()
//        let homeVC = HomeViewController()
//        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
//
//        let naviSearchVC = UINavigationController(rootViewController: SearchViewController())
//        naviSearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
//
//        tabbarVC.viewControllers = [homeVC, naviSearchVC]
//        tabbarVC.title = "Home"
//        self.navigationController?.pushViewController(tabbarVC, animated: true)
      
        idTxf.attributedPlaceholder = NSAttributedString(string: "Email or Username", attributes: placeholderAtts)
        passwordTxf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: placeholderAtts)
        if (!(idTxf.text?.isEmpty)! && !(idTxf.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            !(passwordTxf.text?.isEmpty)! && !(passwordTxf.text?.trimmingCharacters(in: .whitespaces).isEmpty)!){

            let userDb = realm.objects(User.self).filter("id = '\(idTxf.text!)'")
            if(userDb.count > 0){
                print("count > 0")
                try! realm.write {
                    let user = userDb.first!
                    user.pushComment(id_comic: 5365, comment: "this comic is very exciting")
                }
                
//                if(passwordTxf.text! == userDb.first?.password) {
//
//                    let tabbarVC = UITabBarController()
//                    let homeVC = HomeViewController()
//                    homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
//
//                    let naviSearchVC = UINavigationController(rootViewController: SearchViewController())
//                    naviSearchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 2)
//
//                    tabbarVC.viewControllers = [homeVC, naviSearchVC]
//                    tabbarVC.title = "Home"
//
//                    self.navigationController?.pushViewController(tabbarVC, animated: true)
//                }else {
//                    passwordTxf.text = ""
//                    passwordTxf.attributedPlaceholder = NSAttributedString(string: "Password is wrong", attributes: placeholderAtts)
//                }
            }else {
                idTxf.text = ""
                passwordTxf.text = ""
                idTxf.attributedPlaceholder = NSAttributedString(string: "Id is wrong", attributes: placeholderAtts)
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
}

