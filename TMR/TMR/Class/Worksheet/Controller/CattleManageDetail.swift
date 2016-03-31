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
    
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var cattle_name: UITextField!
    @IBOutlet weak var cattle_type: UITextField!
    @IBOutlet weak var cattle_num: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    private func initTableView(){
        
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
        self.cattleModel.cattle_num = Int32(self.cattle_num.text!)!
        let sql = "update cattle_manage set cattle_num=\(self.cattleModel.cattle_num) where cattle_name='\(self.cattleModel.cattle_name)'"
        TMRSQLite().updateData(sql)
    }
    
    
    
}
