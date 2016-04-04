//
//  Worksheet.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import SwiftyJSON

class Worksheet: NSObject {
    
    var worksheet_id:Int32 = 0
    var sheet_name:String = ""
    var forage_name:String = ""
    var origin_weight:Double = 0
    var processed_weight:Double = 0
    var percent:String = ""
    var status:Int32 = 0
    var uploadStatus:Int32 = 0
    var date:String = ""
    var subDate:String = ""
    
    static func getJsonData(sql:String) -> String {
        
        let arrM = NSMutableArray()
        var stmt:COpaquePointer = nil
        let tmrsql = TMRSQLite()
        if !tmrsql.openDatabase() {
            print("打开数据库失败！！！")
        }
        let result = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_OK {
            
            while tmrsql.sqlite_step(stmt) == SQLITE_ROW {
                let dictM = NSMutableDictionary()
                
                dictM.setValue(Int(tmrsql.sqlite_column_int(stmt, index: 0)), forKey: "worksheet_id")
                dictM.setValue(tmrsql.sqlite_column_text(stmt, index: 1), forKey: "sheet_name")
                dictM.setValue(tmrsql.sqlite_column_text(stmt, index: 2), forKey: "forage_name")
                dictM.setValue(tmrsql.sqlite_column_double(stmt, index: 3), forKey: "origin_weight")
                dictM.setValue(tmrsql.sqlite_column_double(stmt, index: 4), forKey: "processed_weight")
                dictM.setValue(tmrsql.sqlite_column_text(stmt, index: 5), forKey: "percent")
                dictM.setValue(Int(tmrsql.sqlite_column_int(stmt, index: 6)), forKey: "status")
                dictM.setValue(Int(tmrsql.sqlite_column_int(stmt, index: 7)), forKey: "uploadStatus")
                dictM.setValue(tmrsql.sqlite_column_text(stmt, index: 8), forKey: "subDate")
                dictM.setValue(tmrsql.sqlite_column_text(stmt, index: 9), forKey: "date")
                dictM.setValue(tmrsql.sqlite_column_text(stmt, index: 10), forKey: "facilityID")
                arrM.addObject(dictM)
            }
            tmrsql.sqlite_finalize(stmt)
        }
        tmrsql.sqlite_close()
        let jsonData:JSON = ["from":"ios", "age":18, "array":arrM]
        return jsonData.rawString()!
    }
    
    static func getDate(sql:String) -> NSMutableArray {
        let arrM = NSMutableArray()
//        let sql = "select distinct date from work_sheet where status=1"
        var stmt:COpaquePointer = nil
        let tmrsql = TMRSQLite()
        if !tmrsql.openDatabase() {
            print("打开数据库失败！！！")
        }
        let result = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_OK {
            
            while tmrsql.sqlite_step(stmt) == SQLITE_ROW {
                let date:String = tmrsql.sqlite_column_text(stmt, index: 0)
                arrM.addObject(date)
            }
            tmrsql.sqlite_finalize(stmt)
        }
        tmrsql.sqlite_close()
        return arrM
    }
    


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
                model.uploadStatus = tmrsql.sqlite_column_int(stmt, index: 7)
                model.subDate = tmrsql.sqlite_column_text(stmt, index: 8)
                model.date = tmrsql.sqlite_column_text(stmt, index: 9)
                
                arrM.addObject(model)
            }
            tmrsql.sqlite_finalize(stmt)
        }
        tmrsql.sqlite_close()
        return arrM
    }
    
}
