//
//  TMRNetworkDetail.swift
//  TMR
//
//  Created by 勒俊 on 16/4/6.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class TMRNetworkDetail: TMRBaseViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayData = NSMutableArray()
    var sheet_nameArray = NSMutableArray()
    var date:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initTableView()
        
        self.getData()
        


        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private func getData() {
    
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRQuery", parameters: ["date": self.date, "facilityID":"ab1001"])
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    if json["count"].int > 0 {
                        let arrJson = json["data"]
                        for i in 0...json["count"].int!-1 {
                    
                            let array = arrJson[i]["array"].arrayValue
                            let arrM = NSMutableArray()
                            for j in 0...array.count-1 {
                                let model = Worksheet()
                                model.forage_name = array[j]["forage_name"].stringValue
                                model.origin_weight = array[j]["origin_weight"].doubleValue
                                model.processed_weight = array[j]["processed_weight"].doubleValue
                                model.percent = array[j]["percent"].stringValue
                                arrM.addObject(model)
                            }
                            let name = arrJson[i]["worksheet_name"].stringValue
                            self.arrayData.addObject(arrM)
                            self.sheet_nameArray.addObject(name)
                        }
                    }
                    
                    self.tableView.reloadData()
                }
                
                MBProgressHUD.hideHUDForView(self.view, animated: true)
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
