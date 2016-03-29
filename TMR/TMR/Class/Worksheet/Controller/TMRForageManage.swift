//
//  TMRForageManage.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRForageManage: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource {

    var forageAddView:ForageAddView?
    var cover:UIButton?
    var arrayData:NSMutableArray? = nil
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rightBtn?.hidden = false
        self.initTableView()
        self.createForageAddView()
        self.arrayData = ForageManage .getAllData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func clickRightBtn() {
        
        self.forageAddView?.isAdd = true
        UIView.animateWithDuration(0.5) { 
            self.forageAddView?.alpha = 0.99
            self.cover?.alpha = 0.99
        }
        self.forageAddView?.clearData()
        self.forageAddView?.isAdd = true
    }

    private func initTableView(){
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        self.tableview.registerNib(UINib.init(nibName: "ForageManageCell", bundle: nil), forCellReuseIdentifier: "ForageManageCell")
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arrayData?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:ForageManageCell = self.tableview.dequeueReusableCellWithIdentifier("ForageManageCell", forIndexPath: indexPath) as! ForageManageCell
        
        let model:ForageManage = self.arrayData![indexPath.row] as! ForageManage
        
        cell.setModel(model)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.forageAddView?.isAdd = false
        UIView.animateWithDuration(0.5) { 
            
            self.forageAddView?.alpha = 0.99
            self.cover?.alpha = 0.99
            self.forageAddView?.setModel(self.arrayData![indexPath.row] as! ForageManage)
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let model:ForageManage = self.arrayData![indexPath.row] as! ForageManage
            let sql = "delete from forage_manage where forage_id=" + String(model.forage_id)
            TMRSQLite().updateData(sql)
            self.arrayData?.removeObjectAtIndex(indexPath.row)
            self.tableview.reloadData()
        }
    }
    
    
    private func createForageAddView(){
        
        self.cover = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
        self.cover?.backgroundColor = UIColor.init(colorLiteralRed: 0.3, green: 0.3, blue: 0.3, alpha: 0.9)
        self.cover?.alpha = 0
        self.view.addSubview(self.cover!)

        forageAddView = NSBundle.mainBundle().loadNibNamed("ForageAddView", owner: nil, options: nil).first as? ForageAddView
        forageAddView?.frame = CGRect.init(x: 20, y: 64 + 12, width: screen_width - 40, height: 175)
        forageAddView?.alpha = 0
        self.view.addSubview(forageAddView!)

        weak var weakSelf = self
        forageAddView?.cancelBlock = {()->() in
            
            UIView.animateWithDuration(0.5, animations: { 
                
                weakSelf!.forageAddView?.alpha = 0
                weakSelf!.cover?.alpha = 0
                
            })
            
        }
        
        forageAddView?.sureBlock = {(forage:ForageManage) -> ()in
            
            if self.forageAddView?.isAdd == true {
                self.arrayData?.addObject(forage)
            }
            UIView.animateWithDuration(0.5, animations: {
                weakSelf!.forageAddView?.alpha = 0
                weakSelf!.cover?.alpha = 0
                weakSelf!.tableview.reloadData()
            })
        }
    }

}
