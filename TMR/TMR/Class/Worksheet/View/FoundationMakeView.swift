//
//  FoundationMakeView.swift
//  TMR
//
//  Created by 勒俊 on 16/3/29.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class FoundationMakeView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var arrayData = NSMutableArray()
    
    var tableView:UITableView!
    var closeBtn:UIButton!
    
    var closeBlock:(()->())!
    var selectBlock:((model:ForageManage)->())!
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.initTableview(frame)
        
        let sql = "select * from \(tableName_forage)"
        self.arrayData = ForageManage.getData(sql)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initTableview(frame: CGRect){
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height - 44), style: UITableViewStyle.Plain)
        self.addSubview(self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "FoundationMakeCell", bundle: nil), forCellReuseIdentifier: "FoundationMakeCell")
        
        self.closeBtn = UIButton.init(frame: CGRect.init(x: 0, y: self.tableView.frame.size.height, width: frame.size.width, height: 44))
        self.addSubview(self.closeBtn)
        self.closeBtn.addTarget(self, action: #selector(FoundationMakeView.closeAction), forControlEvents: UIControlEvents.TouchUpInside)
        self.closeBtn.setTitle("关闭", forState: UIControlState.Normal)
        self.closeBtn.titleLabel?.font = UIFont.systemFontOfSize(23)
    }
    
    func closeAction() {
        
        if closeBlock != nil {
            closeBlock()
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:FoundationMakeCell = self.tableView.dequeueReusableCellWithIdentifier("FoundationMakeCell", forIndexPath: indexPath) as! FoundationMakeCell
        cell.setDataModel(self.arrayData[indexPath.row] as! ForageManage)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if selectBlock != nil {
            selectBlock(model: self.arrayData[indexPath.row] as! ForageManage)
        }
        
    }
    

}
