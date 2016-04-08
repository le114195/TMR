//
//  TMRProcessedDetail.swift
//  TMR
//
//  Created by 勒俊 on 16/4/6.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRProcessedDetail: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayData = NSMutableArray()
    var sheet_nameArray = NSMutableArray()
    var date:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        self.initData()
        
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initData() {
        
        let sql = "select distinct sheet_name from work_sheet where status=1 and date='\(self.date)' and facilityID='\(facilityID)'"
        self.sheet_nameArray = Worksheet.getDate(sql)
        if self.sheet_nameArray.count == 0 {
            return
        }
        for i in 0...self.sheet_nameArray.count-1 {
            let sheetName:String = self.sheet_nameArray[i] as! String
            let modelSql = "select * from work_sheet where status=1 and date='\(self.date)' and sheet_name='\(sheetName)' and facilityID='\(facilityID)'"
            self.arrayData.addObject(Worksheet.getData(modelSql))
        }
    }
    
    private func initTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "ProcessedDetailCell", bundle: nil), forCellReuseIdentifier: "ProcessedDetailCell")
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let arrM:NSMutableArray = self.arrayData[section] as! NSMutableArray
        return arrM.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ProcessedDetailCell = self.tableView.dequeueReusableCellWithIdentifier("ProcessedDetailCell", forIndexPath: indexPath) as! ProcessedDetailCell
        let arrM:NSMutableArray = self.arrayData[indexPath.section] as! NSMutableArray
        cell.setDataModel(arrM[indexPath.row] as! Worksheet)
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sheet_nameArray[section] as? String
    }

}
