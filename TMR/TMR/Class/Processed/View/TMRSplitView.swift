//
//  TMRSplitView.swift
//  TMR
//
//  Created by 勒俊 on 16/4/15.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRSplitView: UIView, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var number: UITextField!
    
    private var num:Int = 2
    
    var cancelBlock:(()->())!
    var sureBlock:(()->())!
    var model:WorksheetModel!
    
    override func awakeFromNib() {
        
        self.initTableView()
        self.number.delegate = self
        self.backgroundColor = UIColor.whiteColor()
        self.alpha = 0
        
    }
    
    
    private func initTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerNib(UINib.init(nibName: "TMRSpliteCell", bundle: nil), forCellReuseIdentifier: "TMRSpliteCell")
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.num
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TMRSpliteCell = self.tableView.dequeueReusableCellWithIdentifier("TMRSpliteCell", forIndexPath: indexPath) as! TMRSpliteCell
        cell.worksheetName.text = model.sheet_name + "_\(indexPath.row + 1)"
        return cell
        
    }
    
    
    @IBAction func sureAction(sender: AnyObject) {
        
        self.endEditing(true)
        
        var sum = 0
        for i in 0...self.num-1 {
            let index = NSIndexPath.init(forRow: i, inSection: 0)
            let cell:TMRSpliteCell = self.tableView.cellForRowAtIndexPath(index) as! TMRSpliteCell
            sum += cell.proportionNum
        }
        
        if sum != 100 {
            TMRHintView.show("输入的比例不正确", view: self)
            return
        }
        
        if self.sureBlock != nil {
            self.sureBlock()
        }
        
        for i in 0...self.num-1 {
            let index = NSIndexPath.init(forRow: i, inSection: 0)
            let cell:TMRSpliteCell = self.tableView.cellForRowAtIndexPath(index) as! TMRSpliteCell
            let modelArray = self.model.worksheetArray
            
            for j in 0...modelArray.count-1 {
                
                let workModel:Worksheet = modelArray[j] as! Worksheet
                
                print(cell.worksheetName.text!)
                
                let sql = "insert into work_sheet (worksheet_id, sheet_name, forage_name, originWeight, processedWeight, percent, status, uploadStatus, subDate, date, facilityID) values (null, '\(cell.worksheetName.text!)', '\(workModel.forage_name)', \(workModel.origin_weight * Double(cell.proportionNum) / Double(100)), 0, '0%', 0, 0, '\(workModel.subDate)', '\(workModel.date)', '\(facilityID)')"
                TMRSQLite().updateData(sql)
            }
        }
        let delSql = "delete from \(tableName_worksheet) where sheet_name='\(self.model.sheet_name)' and facilityID='\(facilityID)'"
        TMRSQLite().updateData(delSql)
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        if self.cancelBlock != nil {
            self.cancelBlock()
        }
        
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if Int(self.number.text!) != nil {
            self.num = Int(self.number.text!)!
            
            if self.num > 5 {
                self.number.text = "5"
                self.num = 5
            }
            
            if self.num < 2 {
                self.number.text = "2"
                self.num = 2
            }
            self.tableView.reloadData()
            
        }else {
            TMRHintView.show("输入格式不正确", view: self)
        }
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.endEditing(true)
    }
    

}
