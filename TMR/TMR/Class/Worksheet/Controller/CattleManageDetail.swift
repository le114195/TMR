//
//  CattleManageDetail.swift
//  TMR
//
//  Created by 勒俊 on 16/3/29.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class CattleManageDetail: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, FoundationMakeViewDelegate, UITextFieldDelegate {
    
    var cattleModel:CattleManage!
    var arrayData = NSMutableArray()
    
    var foundationView:FoundationMakeView!
    var cover:UIView!
    
    var keyboardHeight:CGFloat = 0
    var cellY:CGFloat = 0
    var offset:CGFloat = 0
    var currentIndexPath:NSIndexPath!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var cattle_name: UITextField!
    @IBOutlet weak var cattle_type: UITextField!
    @IBOutlet weak var cattle_num: UITextField!
    
    var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "牛舍基础配方设置"
        
        self.initTableView()
        
        let sql = "select * from \(tableName_foundation) where cattle_name='\(cattleModel.cattle_name)'"
        self.arrayData = FoundationManage.getData(sql)
        
        self.createFoundationView()
        
        self.cattle_type.userInteractionEnabled = false
        self.cattle_name.userInteractionEnabled = false
        
        self.addBtn.layer.cornerRadius = 5
        
        self.cattle_name?.text = self.cattleModel.cattle_name
        self.cattle_type?.text = self.cattleModel.cattle_type
        self.cattle_num?.text = "\(self.cattleModel.cattle_num)"
        self.cattle_num.delegate = self
        self.cattle_num.keyboardType = UIKeyboardType.NumberPad
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(TMRFoundationMake.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }

    
    
    func keyboardWillShow(notifcation:NSNotification) {
        
        let cell:CattleManageDetailCell = self.tableView.cellForRowAtIndexPath(self.currentIndexPath) as! CattleManageDetailCell
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
        rect.origin.y = 154
        self.tableView.frame = rect
        self.offset = 0
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func initTableView(){
        
        self.tableView = UITableView.init(frame: CGRect.init(x: 0, y: 154, width: screen_width, height: screen_height - 275), style: UITableViewStyle.Plain)
        self.view.addSubview(self.tableView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "CattleManageDetailCell", bundle: nil), forCellReuseIdentifier: "CattleManageDetailCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CattleManageDetailCell = self.tableView.dequeueReusableCellWithIdentifier("CattleManageDetailCell", forIndexPath: indexPath) as! CattleManageDetailCell
        
        cell.setDataModel(self.arrayData[indexPath.row] as! FoundationManage
        )
        cell.indexPath = NSIndexPath.init(forRow: indexPath.row, inSection: indexPath.section)
        weak var weakSelf = self
        cell.didselectEdit = {(indexP:NSIndexPath)->() in
            weakSelf!.currentIndexPath = indexP
        }
        cell.showText = {()->() in
            TMRHintView.show("输入格式不正确", view: (weakSelf?.view)!)
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let dataModel = self.arrayData[indexPath.row] as! FoundationManage
            let sql = "delete from \(tableName_foundation) where forage_name='\(dataModel.forage_name)'"
            TMRSQLite().updateData(sql)
            self.arrayData.removeObjectAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    private func createFoundationView()
    {
        self.cover = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
        self.cover.backgroundColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 0.9)
        self.cover.alpha = 0
        self.view.addSubview(self.cover)
        
        self.foundationView = FoundationMakeView.init(frame: CGRect.init(x: 100, y: 100, width: screen_width - 200, height: screen_height - 200))
        
        self.foundationView.setModel(self.cattleModel, oldArrM: self.arrayData)
        self.foundationView.alpha = 0
        self.view.addSubview(self.foundationView)
        weak var weakSelf = self
        self.foundationView.closeBlock = {()->()in
            UIView.animateWithDuration(0.5, animations: {
                weakSelf?.foundationView.alpha = 0
                weakSelf?.cover.alpha = 0
            })
        }
        self.foundationView.delegate = self
    }
    
    
    @IBAction func addAction(sender: AnyObject) {
        
        UIView.animateWithDuration(0.5) {
            self.cover?.alpha = 0.99
            self.foundationView?.alpha = 0.99
        }
    }
    func didselect(model: ForageManage) {
        let sql = "select * from \(tableName_foundation) where cattle_name='\(cattleModel.cattle_name)'"
        self.arrayData = FoundationManage.getData(sql)
        self.tableView.reloadData()
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if Int32(self.cattle_num.text!) == nil {
            TMRHintView.show("牛群数量输入格式不正确", view: self.view)
            self.cattle_num.text = "\(self.cattleModel.cattle_num)"
            return
        }
        self.cattleModel.cattle_num = Int32(self.cattle_num.text!)!
        let sql = "update cattle_manage set cattle_num=\(self.cattleModel.cattle_num) where cattle_name='\(self.cattleModel.cattle_name)'"
        TMRSQLite().updateData(sql)
    }
    
    
    
}
