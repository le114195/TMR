//
//  TMRCattleManage.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRCattleManage: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var arrayData = NSMutableArray()
    
    var cover:UIView!
    var cattleView:CattleView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rightBtn?.hidden = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.arrayData = CattleManage.getAllData()
        
        self.initTableView()
        
        self.createCattleView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightBtn() {
        
        UIView.animateWithDuration(0.5) {
            self.cover.alpha = 0.99
            self.cattleView.alpha = 0.99
        }
        
    }
    
    private func initTableView(){
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerNib(UINib.init(nibName: "CattleManageCell", bundle: nil), forCellReuseIdentifier: "CattleManageCell")
    }
    
    private func createCattleView(){
        
        self.cover = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
        self.cover.backgroundColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 0.9)
        self.cover.alpha = 0
        self.view.addSubview(self.cover)
        
        self.cattleView = NSBundle.mainBundle().loadNibNamed("CattleView", owner: nil, options: nil).first as! CattleView
        self.cattleView.frame = CGRect.init(x: 20, y: 64 + 12, width: screen_width - 40, height: 175)
        self.cattleView.alpha = 0
        self.view.addSubview(self.cattleView)
        
        weak var weakSelf = self
        self.cattleView.cancelBlock = {()->() in
        
            UIView.animateWithDuration(0.5, animations: {
                weakSelf?.cattleView.alpha = 0
                weakSelf?.cover.alpha = 0
            })
            
        }
        
        self.cattleView.sureBlock = {(model:CattleManage)->() in
            
            weakSelf?.arrayData.addObject(model)
            UIView.animateWithDuration(0.5, animations: {
                weakSelf?.cattleView.alpha = 0
                weakSelf?.cover.alpha = 0
            })
            weakSelf?.tableView.reloadData()
        
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CattleManageCell = self.tableView.dequeueReusableCellWithIdentifier("CattleManageCell", forIndexPath: indexPath) as! CattleManageCell
        
        cell.setModel(self.arrayData[indexPath.row] as! CattleManage)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let model:CattleManage = self.arrayData[indexPath.row] as! CattleManage
            let sql = "delete from cattle_manage where cattle_name=" + "'" +  String(model.cattle_name) + "'"
            TMRSQLite().deleteData(sql)
            self.arrayData.removeObjectAtIndex(indexPath.row)
            self.tableView.reloadData()
        }
    }
    
}
