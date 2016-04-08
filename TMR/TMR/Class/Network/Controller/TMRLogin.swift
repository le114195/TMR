//
//  TMRLogin.swift
//  TMR
//
//  Created by 勒俊 on 16/4/3.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import MBProgressHUD
import Alamofire
import SwiftyJSON


class TMRLogin: TMRBaseViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(sender: AnyObject) {
        
        let register = TMRRegister()
        
        self.navigationController?.pushViewController(register, animated: true)
        
    }
    @IBAction func login(sender: AnyObject) {
        
        
        if self.userName.text?.characters.count == 0 ||
            self.password.text?.characters.count == 0 {
            TMRHintView.show("内容不能为空", view: self.view)
            return
        }
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRLoginQuery", parameters: ["user":self.userName.text!, "password":self.password.text!])
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    let json = JSON(response.result.value!)
                    let msg = json["msg"].intValue
                    print(json)
                    if msg == 1 {
                        self.navigationController?.navigationBarHidden = true
                        self.navigationController?.popToRootViewControllerAnimated(true)
                        
                        let defaults = NSUserDefaults.standardUserDefaults()
                        defaults.setObject(json["facilityID"].stringValue, forKey: "facilityID")
                        facilityID = json["facilityID"].stringValue
                    } else if msg == 2 {
                        TMRHintView.show("密码错误", view: self.view)
                    }else if msg == 0 {
                        TMRHintView.show("账号错误", view: self.view)
                    }
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
}
