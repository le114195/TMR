//
//  TMRProcessed.swift
//  TMR
//
//  Created by 勒俊 on 16/4/4.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRProcessed: TMRBaseViewController {
    
    @IBOutlet weak var localBtn: UIButton!
    @IBOutlet weak var originBtn: UIButton!
    @IBOutlet weak var netWorkBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.localBtn.layer.cornerRadius = 10
        self.originBtn.layer.cornerRadius = 10
        self.netWorkBtn.layer.cornerRadius = 10
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func localAction(sender: AnyObject) {
        
        let local = TMRPLocalMonthList()
        self.navigationController?.pushViewController(local, animated: true)
        
    }
    
    @IBAction func originAction(sender: AnyObject) {
        
        
        
    }
    
    @IBAction func networkAction(sender: AnyObject) {
        
        let network = TMRProcessedNetWork()
        
        self.navigationController?.pushViewController(network, animated: true)
        
    }
    
    
    
    

}
