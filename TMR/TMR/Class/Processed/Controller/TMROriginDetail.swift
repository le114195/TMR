//
//  TMROriginDetail.swift
//  TMR
//
//  Created by 勒俊 on 16/4/15.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMROriginDetail: TMRBaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var arrayData = NSMutableArray()
    
    var keyboardHeight:CGFloat = 0
    var cellY:CGFloat = 0
    var offset:CGFloat = 0
    var currentIndexPath:NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initTableView()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)

        
        
        // Do any additional setup after loading the view.
    }

    
    func keyboardWillShow(notifcation:NSNotification) {
        
        
        let cell:TMROriginDetailCell = self.tableView.cellForRowAtIndexPath(self.currentIndexPath) as! TMROriginDetailCell
        self.cellY = self.tableView.convertPoint(cell.frame.origin, toView: self.view).y
        
    }
    
    func keyboardDidShow(notifcation:NSNotification) {
        
        let info = notifcation.userInfo
        let value = info![UIKeyboardFrameEndUserInfoKey]
        let rawFram = value?.CGRectValue()
        keyboardHeight = (rawFram?.size.height)!
        
        self.offset = self.cellY + 60 - (screen_height - keyboardHeight)
        if self.offset > 0 {
            var rect:CGRect = self.tableView.frame
            rect.origin.y -= self.offset
            UIView.animateWithDuration(0.15, animations: {
                self.tableView.frame = rect
            })
        }
    }
    
    func keyboardWillHide(notifcation:NSNotification) {
        
        var rect:CGRect = self.tableView.frame
        rect.origin.y = 0
        self.tableView.frame = rect
        self.offset = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func initTableView(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "TMROriginDetailCell", bundle: nil), forCellReuseIdentifier: "TMROriginDetailCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TMROriginDetailCell = self.tableView.dequeueReusableCellWithIdentifier("TMROriginDetailCell", forIndexPath: indexPath) as! TMROriginDetailCell
        
        cell.setModel(self.arrayData[indexPath.row] as! Worksheet)
        
        cell.indexPath = NSIndexPath.init(forRow: indexPath.row, inSection: indexPath.section)
        weak var weakSelf = self
        cell.didselectEdit = {(indexP:NSIndexPath)->() in
            weakSelf!.currentIndexPath = indexP
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    

}
