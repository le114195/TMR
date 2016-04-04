//
//  TMRLogin.swift
//  TMR
//
//  Created by 勒俊 on 16/4/3.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRLogin: TMRBaseViewController {

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(sender: AnyObject) {
        
        
        
    }
    @IBAction func login(sender: AnyObject) {
        
        let worksheet = TMRWorksheet()
        self.navigationController?.pushViewController(worksheet, animated: true)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject("ab1001", forKey: "facilityID")
    }
}
