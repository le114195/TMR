//
//  TMROriginWorksheet.swift
//  TMR
//
//  Created by 勒俊 on 16/4/15.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMROriginWorksheet: TMRBaseViewController,UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var capacity: UITextField!
    
    var capacityD:Double = 0
    
    lazy private var splitView:TMRSplitView = {
        
        let temp = NSBundle.mainBundle().loadNibNamed("TMRSplitView", owner: nil, options: nil).first as! TMRSplitView
        temp.frame = CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height)
        self.view.addSubview(temp)
        
        weak var weakTemp = temp
        weak var weakSelf = self
        temp.cancelBlock = {()->() in
            
            UIView.animateWithDuration(0.25, animations: { 
                weakTemp?.alpha = 0
            })
            weakSelf?.navigationController?.navigationBarHidden = false
        }
        temp.sureBlock = {()->() in
            UIView.animateWithDuration(0.25, animations: {
                weakTemp?.alpha = 0
            })
            weakSelf?.navigationController?.navigationBarHidden = false
        }
        
        return temp
        
    }()
    
    
    private var arrayData = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        self.arrayData = WorksheetModel.getData()
        self.capacity.delegate = self
        
        
        
        let capacity = NSUserDefaults.standardUserDefaults().valueForKey("capacity")
        if capacity != nil {
            self.capacity.text = "\(capacity!)"
            self.capacityD = capacity as! Double
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initTableView(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "TMROriginListCell", bundle: nil), forCellReuseIdentifier: "TMROriginListCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TMROriginListCell = self.tableView.dequeueReusableCellWithIdentifier("TMROriginListCell", forIndexPath: indexPath) as! TMROriginListCell
        
        let model = self.arrayData[indexPath.row] as! WorksheetModel
        cell.setModelData(model)
        if self.capacityD < model.allShouldWeight {
            cell.button.hidden = false
        }else {
            cell.button.hidden = true
        }
        
        weak var weakSelf = self
        cell.clickBtvBlock = {()->() in
            
            UIView.animateWithDuration(0.25, animations: {
                weakSelf?.splitView.alpha = 0.99
            })
            weakSelf?.splitView.model = model
            weakSelf?.navigationController?.navigationBarHidden = true
            weakSelf?.splitView.tableView.reloadData()
        }
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let origin = TMROriginDetail()
        let model = self.arrayData[indexPath.row] as! WorksheetModel
        origin.arrayData = model.worksheetArray
        self.navigationController?.pushViewController(origin, animated: true)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let dataModel = self.arrayData[indexPath.row] as! WorksheetModel
            let sql = "delete from \(tableName_worksheet) where sheet_name='\(dataModel.sheet_name)' and status = 0"
            TMRSQLite().updateData(sql)
            self.arrayData.removeObjectAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if Double(self.capacity.text!) != nil {
            if Double(self.capacity.text!) != self.capacityD {
                self.capacityD = Double(self.capacity.text!)!
                NSUserDefaults.standardUserDefaults().setValue(self.capacityD, forKey: "capacity")
                self.tableView.reloadData()
            }
        }else {
            TMRHintView.show("输入格式有错", view: self.view)
            return
        }
    }
    
}
