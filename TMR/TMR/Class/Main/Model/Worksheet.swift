//
//  Worksheet.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class Worksheet: NSObject {
    
    var worksheet_id:Int32 = 0
    var sheet_name:String = ""
    var forage_name:String = ""
    var origin_weight:Double = 0
    var processed_weight:Double = 0
    var percent:String = ""
    var status:Int32 = 0
    

    static func getData(sql:String) -> NSMutableArray {
        
        let arrM = NSMutableArray()
        var stmt:COpaquePointer = nil
        
        let tmrsql = TMRSQLite()
        
        if !tmrsql.openDatabase() {
            print("打开数据库失败！！！")
        }
        let result = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_OK {
            
            while tmrsql.sqlite_step(stmt) == SQLITE_ROW {
                let model = Worksheet()
                model.worksheet_id = tmrsql.sqlite_column_int(stmt, index: 0)
                model.sheet_name = tmrsql.sqlite_column_text(stmt, index: 1)
                model.forage_name = tmrsql.sqlite_column_text(stmt, index: 2)
                model.origin_weight = tmrsql.sqlite_column_double(stmt, index: 3)
                model.processed_weight = tmrsql.sqlite_column_double(stmt, index: 4)
                model.percent = tmrsql.sqlite_column_text(stmt, index: 5)
                model.status = tmrsql.sqlite_column_int(stmt, index: 6)
                
                arrM.addObject(model)
            }
            tmrsql.sqlite_finalize(stmt)
        }
        return arrM
    }
    
}
