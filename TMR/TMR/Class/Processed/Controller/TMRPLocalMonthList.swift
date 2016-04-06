//
//  TMRPLocalMonthList.swift
//  TMR
//
//  Created by 勒俊 on 16/4/4.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRPLocalMonthList: TMRBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayData = NSMutableArray()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        
        let sql = "select distinct subDate from work_sheet where status=1"
        
        self.arrayData = Worksheet.getDate(sql)
        
        // Do any additional setup after loading the view.
    }

    private func initTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) 
        
        cell.textLabel?.text = self.arrayData[indexPath.row] as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let dayLocal = TMRPLocalDayList()
        dayLocal.subDate = self.arrayData[indexPath.row] as! String
        self.navigationController?.pushViewController(dayLocal, animated: true)
        
    }
    

}
