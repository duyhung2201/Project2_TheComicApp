//
//  SignupViewController.swift
//  project2
//
//  Created by Macintosh on 5/27/19.
//  Copyright © 2019 HoaPQ. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
class SignupViewController: UIViewController {
    var id : ((String) -> ())?
    
    let realm = try! Realm()
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
    
    lazy var cfPasswordTxf: BaseTxf = {
        let cfPasswordTxf = BaseTxf()
        cfPasswordTxf.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: placeholderAtts)
        cfPasswordTxf.addTarget(self, action: #selector(txfEditBegin), for: .editingDidBegin)
        cfPasswordTxf.addTarget(self, action: #selector(txfEditEnd), for: .editingDidEnd)
        cfPasswordTxf.backgroundColor = #colorLiteral(red: 0.9060392833, green: 0.9060392833, blue: 0.9060392833, alpha: 1)
        cfPasswordTxf.layer.cornerRadius = 15
        cfPasswordTxf.layer.masksToBounds = true
        cfPasswordTxf.layer.borderWidth = 0
        
        cfPasswordTxf.isSecureTextEntry = true
        return cfPasswordTxf
    }()
    
    lazy var signupBtn : UILabel = {
        let signupBtn = UILabel()
        signupBtn.text = "Signup"
        signupBtn.textAlignment = .center
        signupBtn.font = UIFont.boldSystemFont(ofSize: 17)
        signupBtn.textColor = .white
        signupBtn.backgroundColor = #colorLiteral(red: 0.1301730486, green: 0.3706113673, blue: 0.5702153928, alpha: 1)
        signupBtn.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapSignup))
        signupBtn.addGestureRecognizer(tap)
        signupBtn.layer.cornerRadius = 15
        signupBtn.layer.masksToBounds = true
        signupBtn.layer.borderWidth = 1
        
        return signupBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()

    }
    
    
    func initLayout() {
        self.title = "Signup"
        self.view.addSubview(idTxf)
        self.view.addSubview(passwordTxf)
        self.view.addSubview(imgView)
        self.view.addSubview(cfPasswordTxf)
        self.view.addSubview(signupBtn)
        setImgViewLayout()
        setIdTxfLayout()
        setPasswordTxfLayout()
        setCfPasswordTxfLayout()
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
    func setCfPasswordTxfLayout() {
        self.cfPasswordTxf.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(15)
            make.right.equalTo(self.view).offset(-15)
            make.top.equalTo(passwordTxf.snp.bottom).offset(20)
            make.height.equalTo(40)
        }
        
    }
    
    func setSinupBtnLayout() {
        self.signupBtn.snp.makeConstraints { (make) in
            make.top.equalTo(cfPasswordTxf.snp.bottom).offset(20)
            make.centerX.equalTo(self.view)
            make.width.equalTo(90)
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
    
    @objc func tapSignup() {
        idTxf.attributedPlaceholder = NSAttributedString(string: "Email or Username", attributes: placeholderAtts)
        
        if (!(idTxf.text?.isEmpty)! && !(idTxf.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            !(passwordTxf.text?.isEmpty)! && !(passwordTxf.text?.trimmingCharacters(in: .whitespaces).isEmpty)! &&
            passwordTxf.text == cfPasswordTxf.text){
            let user = User(id: idTxf.text!, password: passwordTxf.text!)
            if realm.objects(User.self).filter("id = '\(idTxf.text!)'").count == 0 {
                try! realm.write {
                    realm.add(user, update: false)
                }
                self.id?(idTxf.text!)
                self.navigationController?.popViewController(animated: false)
            }else {
                idTxf.text = ""
                passwordTxf.text = ""
                cfPasswordTxf.text = ""
                idTxf.attributedPlaceholder = NSAttributedString(string: "Id was already existed", attributes: placeholderAtts)
            }
        }
    }
    
}


