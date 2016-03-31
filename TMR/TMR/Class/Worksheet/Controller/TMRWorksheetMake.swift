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
    
    private weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "开始制作加工单"
        
        self.createFSCalendar()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func createFSCalendar(){
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 64, width: screen_width, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        
        self.view.addSubview(calendar)
        self.calendar = calendar
    }
    
    func minimumDateForCalendar(calendar: FSCalendar) -> NSDate {
        return NSDate.init()
    }
    
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        
        print(date)
        
    }
    
    
}
