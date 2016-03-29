//
//  FoundationManage.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class FoundationManage: NSObject {
    
    var cattle_name:String = ""
    var forage_name:String = ""
    var cattle_type:String = ""
    var forage_weight:Double = 0
    var foundation_id:Int32 = 0

    
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
                let model = FoundationManage()

                model.cattle_name = tmrsql.sqlite_column_text(stmt, index: 0)
                model.forage_name = tmrsql.sqlite_column_text(stmt, index: 1)
                model.cattle_type = tmrsql.sqlite_column_text(stmt, index: 2)
                model.forage_weight = tmrsql.sqlite_column_double(stmt, index: 3)
                model.foundation_id = tmrsql.sqlite_column_int(stmt, index: 4)
                arrM.addObject(model)
            }
            tmrsql.sqlite_finalize(stmt)
        }
        return arrM
    }
    
}
