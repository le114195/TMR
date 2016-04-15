//
//  TMRSplitView.swift
//  TMR
//
//  Created by 勒俊 on 16/4/15.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRSplitView: UIView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var number: UITextField!
    
    var cancelBlock:(()->())!
    var sureBlock:(()->())!
    
    
    
    override func awakeFromNib() {
        
        
        
    }
    
    
    private func initTableView() {
        
        
        
        
        
    }
    
    
    
    @IBAction func sureAction(sender: AnyObject) {
        
        if self.sureBlock != nil {
            self.sureBlock()
        }
        
        
        
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        if self.cancelBlock != nil {
            self.cancelBlock()
        }
        
        
    }
    

}
