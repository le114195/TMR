//
//  TMRWorksheetMake.swift
//  TMR
//
//  Created by 勒俊 on 16/3/31.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import FSCalendar

class TMRWorksheetMake: TMRBaseViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var makeBtn: UIButton!
    @IBOutlet weak var showText: UITextView!
    
    var formatter:NSDateFormatter!
    var worksheetTime:String = ""
    var alert:UIAlertController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "开始制作加工单"
        self.createFSCalendar()
        self.createAlert()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func makeAction(sender: AnyObject) {
        
        let workSql = "select * from work_sheet where sheet_name like '\(self.worksheetTime)%'"
        let workArray = Worksheet.getData(workSql)
        if workArray.count > 0 {
            print(self.worksheetTime + "的加工单已经存在")
            
            TMRHintView.show(self.worksheetTime + "的加工单已经存在", view: self.view)
            
            return
        }
        
        self.presentViewController(self.alert, animated: true, completion: nil)
        
    }
    
    private func createSheet(){
        
        
        let cattleSql = "select * from cattle_manage"
        let cattleArray = CattleManage.getData(cattleSql)
        for i in 0...cattleArray.count-1 {
            let cattleModel:CattleManage = cattleArray[i] as! CattleManage
            let foundationSql = "select * from foundation_manage where cattle_name='\(cattleModel.cattle_name)'"
            let foundationArray = FoundationManage.getData(foundationSql)
            if foundationArray.count == 0 {
                continue
            }
            for j in 0...foundationArray.count-1 {
                
                let foundationModel:FoundationManage = foundationArray[j] as! FoundationManage
                
                self.createWorksheet(cattleModel, foundation_model: foundationModel, index: 0)
                self.createWorksheet(cattleModel, foundation_model: foundationModel, index: 1)
                self.createWorksheet(cattleModel, foundation_model: foundationModel, index: 2)
            }
        }

        
        
    }
    
    private func createWorksheet(cattle_model:CattleManage, foundation_model:FoundationManage, index:Int32) {
        
        var sql:String = ""
        var originWeight:Double = 0
        var work_sheet:String = ""
        
        switch index {
        case 0:
            originWeight = Double(cattle_model.morning_proportion) * foundation_model.forage_weight * Double(cattle_model.cattle_num) / 100
            sql = "insert into work_sheet (worksheet_id, sheet_name, forage_name, originWeight, processedWeight, percent, status) values (null, '\(worksheetTime)_\(cattle_model.cattle_name)_早_0', '\(foundation_model.forage_name)', \(originWeight), 0, '0%', 0)"
            work_sheet = "\(worksheetTime)_\(cattle_model.cattle_name)_早_0\t\(foundation_model.forage_name)\t\(originWeight)"
            break
            
        case 1:
            
            originWeight = Double(cattle_model.nooning_proportion) * foundation_model.forage_weight * Double(cattle_model.cattle_num) / 100
            sql = "insert into work_sheet (worksheet_id, sheet_name, forage_name, originWeight, processedWeight, percent, status) values (null, '\(worksheetTime)_\(cattle_model.cattle_name)_中_1', '\(foundation_model.forage_name)', \(originWeight), 0, '0%', 0)"
            work_sheet = "\(worksheetTime)_\(cattle_model.cattle_name)_中_1\t\(foundation_model.forage_name)\t\(originWeight)"
            break
            
        case 2:
            
            originWeight = Double(cattle_model.evening_proportion) * foundation_model.forage_weight * Double(cattle_model.cattle_num) / 100
            sql = "insert into work_sheet (worksheet_id, sheet_name, forage_name, originWeight, processedWeight, percent, status) values (null, '\(worksheetTime)_\(cattle_model.cattle_name)_晚_2', '\(foundation_model.forage_name)', \(originWeight), 0, '0%', 0)"
            work_sheet = "\(worksheetTime)_\(cattle_model.cattle_name)_晚_2\t\(foundation_model.forage_name)\t\(originWeight)"
            break
        default:
            break
        }
        if originWeight > 0 {
            TMRSQLite().updateData(sql)
            self.showText.text = "\(work_sheet)\n" + self.showText.text
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func createFSCalendar(){
        self.calendar.dataSource = self
        self.calendar.delegate = self
        self.makeBtn.layer.cornerRadius = 5
        self.showText.userInteractionEnabled = false
        
        self.formatter = NSDateFormatter.init()
        self.formatter.dateFormat = "yyyy-MM-dd"
        
        self.worksheetTime = self.formatter.stringFromDate(NSDate.init())
        
    }
    
    private func createAlert(){
        
        self.alert = UIAlertController.init(title: "是否确定制作加工单", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        weak var weakSelf = self
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default) { (okAction) in
            weakSelf!.createSheet()
        }
        self.alert.addAction(cancelAction)
        self.alert.addAction(okAction)
    }
    
    func minimumDateForCalendar(calendar: FSCalendar) -> NSDate {
        return NSDate.init()
    }
    
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        self.worksheetTime = self.formatter.stringFromDate(date)
        
    }
    
    
}
