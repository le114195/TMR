//
//  TMRProcessedNetWork.swift
//  TMR
//
//  Created by 勒俊 on 16/4/6.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import FSCalendar

class TMRProcessedNetWork: TMRBaseViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var sureBtn: UIButton!
    
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
        
        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        self.date = self.formatter.stringFromDate(date)
    }
    
    
    @IBAction func sureAction(sender: AnyObject) {
        
        let detail = TMRNetworkDetail()
        detail.date = self.date
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    

}
