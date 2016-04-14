//
//  TMRAnalyze.swift
//  TMR
//
//  Created by 勒俊 on 16/4/13.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class TMRAnalyze: TMRBaseViewController {

    private var arrayData = NSMutableArray()
    private var arrayDate = NSMutableArray()
    weak private var analyzeView:TMRAnalyzeView!
    
    lazy var dateFormat:NSDateFormatter = {
        
        let temp = NSDateFormatter()
        temp.dateFormat = "yyyy-MM-dd"
        return temp
    }()
    var beginDate:String = ""
    var endDate:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createSubView()
        
        self.beginDate = self.dateFormat.stringFromDate(NSDate.init())
        self.endDate = self.dateFormat.stringFromDate(NSDate.init())
        // Do any additional setup after loading the view.
    }
    
    func dateSelect(datePick:UIDatePicker) {
        
        let date = datePick.date
        beginDate = dateFormat.stringFromDate(date)

        
    }
    
    func endSelect(datePick:UIDatePicker) {
        let date = datePick.date
        endDate = dateFormat.stringFromDate(date)
    }
    
    private func createAnalyzeView() {
        
        let temp = TMRAnalyzeView()
        temp.frame = CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height)
        temp.alpha = 0
        self.view.addSubview(temp)
        
        weak var weakTemp = temp
        temp.closeBlock = {()->() in
            weakTemp!.alpha = 0
            weakTemp?.removeFromSuperview()
            weakTemp = nil
        }

        self.analyzeView = temp
    }
    
    
    private func createSubView() {
    
        
        let beginLabel = UILabel.init(frame: CGRect.init(x: 0, y: 64, width: screen_width, height: 25))
        beginLabel.textAlignment = NSTextAlignment.Center
        beginLabel.text = "请选择开始时间"
        self.view.addSubview(beginLabel)
        
        let datePick = UIDatePicker()
        datePick.frame = CGRect.init(x: 0, y: 64 + 25, width: screen_width, height: 100)
        datePick.datePickerMode = UIDatePickerMode.Date
        datePick.addTarget(self, action: #selector(TMRAnalyze.dateSelect(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(datePick)
        
        
        let endLabel = UILabel.init(frame: CGRect.init(x: 0, y: 189 + 50, width: screen_width, height: 25))
        endLabel.textAlignment = NSTextAlignment.Center
        endLabel.text = "请选择结束时间"
        self.view.addSubview(endLabel)
        
        let endDate = UIDatePicker()
        endDate.frame = CGRect.init(x: 0, y: 189 + 75, width: screen_width, height: 100)
        endDate.datePickerMode = UIDatePickerMode.Date
        endDate.addTarget(self, action: #selector(TMRAnalyze.endSelect(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(endDate)
        
        
        let btn = UIButton.init(frame: CGRect.init(x: 70, y: screen_height - 130, width: screen_width - 140, height: 70))
        
        btn.setTitle("确定", forState: UIControlState.Normal)
        
        btn.backgroundColor = UIColor.blueColor()
        btn.addTarget(self, action: #selector(TMRAnalyze.sureAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(btn)

    }
    
    
    func sureAction() {
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        self.arrayData.removeAllObjects()
        self.arrayDate.removeAllObjects()
        
        Alamofire.request(.POST, "http://139.129.8.9:8080/TMRServerNew/TMRAnalyze", parameters: ["beginDate":beginDate, "endDate":endDate, "facilityID":facilityID])
            .responseJSON { response in
                if response.result.isSuccess {
                    let json = JSON(response.result.value!)
                    let arrJson = json["data"]
                    for i in 0...json["count"].int!-1 {
                        let array = arrJson[i]["array"].arrayValue
                        let arrM = NSMutableArray()
                        for j in 0...array.count-1 {
                            let dict = NSMutableDictionary()
                            dict.setValue(array[j]["difference"].doubleValue, forKey: "difference")
                            dict.setValue(array[j]["percent"].doubleValue, forKey: "percent")
                            dict.setValue(array[j]["worksheet_name"].stringValue, forKey: "worksheet_name")
                            arrM.addObject(dict)
                        }
                        let name = arrJson[i]["date"].stringValue
                        self.arrayDate.addObject(name)
                        self.arrayData.addObject(arrM)
                    }
                    
                    UIView.animateWithDuration(0.25, animations: {
                        if self.analyzeView == nil {
                            self.createAnalyzeView()
                        }
                        self.analyzeView.alpha = 0.99
                    })
                    self.analyzeView.setDataModel(self.arrayData, dateArray: self.arrayDate)
                    
                }
                MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
