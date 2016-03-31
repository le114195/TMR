//
//  TMRFoundationMake.swift
//  TMR
//
//  Created by 勒俊 on 16/3/31.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRFoundationMake: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var arrayData = NSMutableArray()
    var keyboardHeight:CGFloat = 0
    var cellY:CGFloat = 0
    var offset:CGFloat = 0
    var currentIndexPath:NSIndexPath!
    var tableView:UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.initTableview()
        self.title = "基础配方"
        
        let sql = "select * from cattle_manage"
        self.arrayData = CattleManage.getData(sql)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }

    func keyboardWillShow(notifcation:NSNotification) {
        
        let cell:TMRFoundationMakeCell = self.tableView.cellForRowAtIndexPath(self.currentIndexPath) as! TMRFoundationMakeCell
        self.cellY = self.tableView.convertPoint(cell.frame.origin, toView: self.view).y
        
    }
    
    func keyboardDidShow(notifcation:NSNotification) {
        
        let info = notifcation.userInfo
        let value = info![UIKeyboardFrameEndUserInfoKey]
        let rawFram = value?.CGRectValue()
        keyboardHeight = (rawFram?.size.height)!
        
        self.offset = self.cellY + 130 - (screen_height - keyboardHeight)
        if self.offset > 0 {
            var rect:CGRect = self.tableView.frame
            rect.origin.y -= self.offset
            UIView.animateWithDuration(0.15, animations: { 
                self.tableView.frame = rect
            })
            
        }
        
        print(rawFram)
        
    }
    
    func keyboardWillHide(notifcation:NSNotification) {
        
        var rect:CGRect = self.tableView.frame
        rect.origin.y = 0
        self.tableView.frame = rect
        self.offset = 0
    }
    
    
    private func initTableview() {
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height), style: UITableViewStyle.Plain)
        self.view.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.registerNib(UINib.init(nibName: "TMRFoundationMakeCell", bundle: nil), forCellReuseIdentifier: "TMRFoundationMakeCell")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TMRFoundationMakeCell = self.tableView.dequeueReusableCellWithIdentifier("TMRFoundationMakeCell", forIndexPath: indexPath) as! TMRFoundationMakeCell

        cell.setDataModel(self.arrayData[indexPath.row] as! CattleManage)
        cell.indexPath = NSIndexPath.init(forRow: indexPath.row, inSection: indexPath.section)
        weak var weakSelf = self
        cell.didselectEdit = {(indexP:NSIndexPath)->() in
            weakSelf!.currentIndexPath = indexP
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    

}
