//
//  TMRNavigationController.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRNavigationController: UINavigationController,UINavigationControllerDelegate, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.interactivePopGestureRecognizer?.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
        self.interactivePopGestureRecognizer?.enabled = true
        
    }
    
    
    

}
