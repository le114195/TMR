//
//  WorksheetModel.swift
//  TMR
//
//  Created by 勒俊 on 16/4/2.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class WorksheetModel: NSObject {

    var sheet_name:String = ""
    var worksheetArray = NSMutableArray()
    var allShouldWeight:Double = 0
    var allRealityWeight:Double = 0
    
    
    static func getData(index:Int32) -> NSMutableArray {
        
        let formatter = NSDateFormatter.init()
        formatter.dateFormat = "yyyy-MM-dd"
        let today = formatter.stringFromDate(NSDate.init())
        let sql:String = "select distinct sheet_name from work_sheet  where sheet_name like '\(today)_\(index)%'"
        
        let arrM = NSMutableArray()
        var stmt:COpaquePointer = nil
        let tmrsql = TMRSQLite()
        if !tmrsql.openDatabase() {
            print("打开数据库失败！！！")
        }
        let result = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_OK {
            
            while tmrsql.sqlite_step(stmt) == SQLITE_ROW {
                let model = WorksheetModel()
                
                model.sheet_name = tmrsql.sqlite_column_text(stmt, index: 0)
                let modelSql = "select * from work_sheet where sheet_name='\(model.sheet_name)'"
                model.worksheetArray = Worksheet.getData(modelSql)
                
                for i in 0...model.worksheetArray.count-1 {
                    let workModel:Worksheet = model.worksheetArray[i] as! Worksheet
                    model.allShouldWeight += workModel.origin_weight
                    model.allRealityWeight += workModel.processed_weight
                }
                arrM.addObject(model)
            }
            tmrsql.sqlite_finalize(stmt)
        }
        tmrsql.sqlite_close()
        return arrM
    }
    
    
    
    
}
