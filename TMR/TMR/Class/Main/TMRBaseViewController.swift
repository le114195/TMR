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
    var rightBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        rightBtn = UIButton.init(type: UIButtonType.ContactAdd)
        rightBtn!.addTarget(self, action: #selector(TMRForageManage.clickRightBtn), forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn!)
        rightBtn!.hidden = true
    }
    
    func clickLeftBtn() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func clickRightBtn() {
        
    }
}
