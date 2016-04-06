//
//  TMRBaseViewController.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRBaseViewController: UIViewController {

    var leftBtn:UIButton?
    lazy var rightBtn:UIButton = {
        let tempBtn = UIButton.init(type: UIButtonType.ContactAdd)
        tempBtn.addTarget(self, action: #selector(TMRForageManage.clickRightBtn), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: tempBtn)
        tempBtn.hidden = true
        return tempBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.createItemBtn()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createItemBtn() {
        
        leftBtn = UIButton.init(type: UIButtonType.Custom)
        leftBtn!.frame = CGRect.init(x: 8, y: 30, width: 22, height: 22)
        leftBtn!.setImage(UIImage.init(named: "return_black"), forState: UIControlState.Normal)
        leftBtn!.setImage(UIImage.init(named: "return_gray"), forState: UIControlState.Highlighted)
        leftBtn!.addTarget(self, action: #selector(TMRBaseViewController.clickLeftBtn), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn!)
        
        }
    
    func clickLeftBtn() {
        self.view.endEditing(true)
        self.navigationController?.popViewControllerAnimated(true)
    }
    func clickRightBtn() {
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    
    deinit {
        print("free!!!")
    }
    
    
    
    
}
