//
//  TMRProcessedNetWork.swift
//  TMR
//
//  Created by 勒俊 on 16/4/6.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import FSCalendar
import Alamofire
import SwiftyJSON
import MBProgressHUD

class TMRProcessedNetWork: TMRBaseViewController, FSCalendarDelegate, FSCalendarDataSource, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var facilityID:String = ""
    
    var arrayData = NSMutableArray()
    var date:String = ""
    
    lazy var formatter:NSDateFormatter = {
        
        let temp = NSDateFormatter.init()
        temp.dateFormat = "yyyy-MM-dd"
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.delegate = self
        self.calendar.dataSource = self
        
        self.date = self.formatter.stringFromDate(NSDate.init())
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerNib(UINib.init(nibName: "TMRFacilityCell", bundle: nil), forCellReuseIdentifier: "TMRFacilityCell")
        
        self.initData()
        
        // Do any additional setup after loading the view.
    }

    private func initData() {
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRLoginQuery", parameters: nil)
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    let count = json["count"].intValue
                    if count > 0 {
                        for i in 0...count {
                            let dict = NSMutableDictionary()
                            dict.setValue(json["data"][i]["name"].stringValue, forKey: "name")
                            dict.setValue(json["data"][i]["user"].stringValue, forKey: "user")
                            dict.setValue(json["data"][i]["facilityID"].stringValue, forKey: "facilityID")
                            self.arrayData.addObject(dict)
                            self.tableView.reloadData()
                        }
                        
                    }
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        self.date = self.formatter.stringFromDate(date)
    }
    
    
    @IBAction func analyzeAction(sender: AnyObject) {
        
        let analyze = TMRAnalyze()
        self.navigationController?.pushViewController(analyze, animated: true)
    }
    
    
    @IBAction func sureAction(sender: AnyObject) {
        
        if self.facilityID.characters.count == 0 {
            TMRHintView.show("请选择加工厂", view: self.view)
            return
        }
        
        let detail = TMRNetworkDetail()
        detail.date = self.date
        detail.facilityID = self.facilityID
        self.navigationController?.pushViewController(detail, animated: true)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TMRFacilityCell = self.tableView.dequeueReusableCellWithIdentifier("TMRFacilityCell", forIndexPath: indexPath) as! TMRFacilityCell
        
        let dict:NSMutableDictionary = self.arrayData[indexPath.row] as! NSMutableDictionary
        cell.nameLabel.text = dict.valueForKey("name") as? String
        cell.userLabel.text = dict.valueForKey("user") as? String
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let dict:NSMutableDictionary = self.arrayData[indexPath.row] as! NSMutableDictionary
        self.facilityID = (dict.valueForKey("facilityID") as? String)!
    }

}
