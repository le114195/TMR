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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.delegate = self
        self.calendar.dataSource = self

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func calendar(calendar: FSCalendar, didSelectDate date: NSDate) {
        
        
        
    }
    
    
    
    
    
    
    

}
