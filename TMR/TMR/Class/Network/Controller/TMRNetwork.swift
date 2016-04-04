//
//  TMRNetwork.swift
//  TMR
//
//  Created by 勒俊 on 16/3/27.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class TMRNetwork: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    private var arrayData = NSMutableArray()
    
    lazy var alert:UIAlertController = {
        let tempAlert = UIAlertController.init(title: "是否确定制作加工单", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        weak var weakSelf = self
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default) { (okAction) in
            weakSelf!.uploadAllData()
        }
        tempAlert.addAction(cancelAction)
        tempAlert.addAction(okAction)
        return tempAlert
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sql = "select distinct date from work_sheet where status=1 and uploadStatus=0"
        self.arrayData = Worksheet.getDate(sql)
        self.initTableView()
        
        // Do any additional setup after loading the view.
    }

    private func initTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "NetWorkCell", bundle: nil), forCellReuseIdentifier: "NetWorkCell")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func uploadAction(sender: AnyObject) {
        
        
        if self.arrayData.count == 0 {
            return
        }
        
        self.presentViewController(self.alert, animated: true, completion: nil)
        
    }
    
    private func uploadAllData() {
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let sql:String = "select * from work_sheet where status=1 and uploadStatus=0"
        let jsonObject: AnyObject = Worksheet.getJsonData(sql)
        
        Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRInsertData", parameters: ["foo": "gg", "data":jsonObject])
            .responseJSON { response in
                if response.result.isSuccess {
                    print("上传成功！！！")
                    let upSql = "update work_sheet set uploadStatus=1 where status=1'"
                    TMRSQLite().updateData(upSql)
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                }
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:NetWorkCell = self.tableView.dequeueReusableCellWithIdentifier("NetWorkCell", forIndexPath: indexPath) as! NetWorkCell
        
        cell.setModelData(self.arrayData[indexPath.row] as! String)
        weak var weakSelf = self
        
        weak var weakCell = cell
        cell.uploadBlock = {()->() in
            MBProgressHUD.showHUDAddedTo(weakSelf!.view, animated: true)
            let sql:String = "select * from work_sheet where status=1 and uploadStatus=0 and date='\(weakCell!.date)'"
            let jsonObject: AnyObject = Worksheet.getJsonData(sql)
            
            Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRInsertData", parameters: ["foo": "gg", "data":jsonObject])
                .responseJSON { response in
                    if response.result.isSuccess {
                        
                        let upSql = "update work_sheet set uploadStatus=1 where status=1 and date='\(weakCell!.date)'"
                        TMRSQLite().updateData(upSql)
                        weakSelf?.arrayData.removeObjectAtIndex(indexPath.row)
                        weakSelf?.tableView.reloadData()
                        MBProgressHUD.hideHUDForView(weakSelf!.view, animated: true)
                    }
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
}
