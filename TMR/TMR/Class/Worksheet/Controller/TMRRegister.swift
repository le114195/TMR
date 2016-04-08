//
//  TMRRegister.swift
//  TMR
//
//  Created by 勒俊 on 16/4/8.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class TMRRegister: TMRBaseViewController, UITextFieldDelegate {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var affirmPasswordText: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var userShow: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userText.delegate = self;
        self.userShow.hidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        
        
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func registerAction(sender: AnyObject) {
        
        if self.userShow.hidden == false {
            return
        }
        
        if self.nameText.text?.characters.count == 0 ||
        self.userText.text?.characters.count == 0 ||
        self.passwordText.text?.characters.count == 0 ||
            self.affirmPasswordText.text?.characters.count == 0 {
        
            TMRHintView.show("内容不能为空", view: self.view)
            return
        }
        
        if self.passwordText.text != self.affirmPasswordText.text {
            TMRHintView.show("两次密码不一致", view: self.view)
            return
        }
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRRegisterUser", parameters: ["name": self.nameText.text!, "user":self.userText.text!, "password":self.passwordText.text!])
            .responseJSON { response in
                if response.result.isSuccess {
                    self.navigationController?.popViewControllerAnimated(true)
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        
        if self.userText.text?.characters.count == 0 {
            return
        }
        Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRLoginQuery", parameters: ["user":self.userText.text!, "password":""])
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    let msg = json["msg"].intValue
                    if msg == 0 {
                        self.userShow.hidden = true
                    }else {
                        self.userShow.hidden = false
                    }
                    
                }
        }

    }
}
