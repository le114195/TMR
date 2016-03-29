//
//  CattleManage.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class CattleManage: NSObject {

    
    var cattle_name:String = ""
    var cattle_type:String = ""
    var cattle_num:Int32 = 0
    var morning_proportion:Int32 = 0
    var nooning_proportion:Int32 = 0
    var evening_proportion:Int32 = 0
    var cattle_id:Int32 = 0
    
    static func getAllData() -> NSMutableArray {
        
        let arrM = NSMutableArray()
        var stmt:COpaquePointer = nil
        
        let tmrsql = TMRSQLite()
        
        if !tmrsql.openDatabase() {
            print("打开数据库失败！！！")
        }
        let sql = "select * from cattle_manage"
        let result = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_OK {
            
            while tmrsql.sqlite_step(stmt) == SQLITE_ROW {
                let cattle = CattleManage()
                
                cattle.cattle_name = tmrsql.sqlite_column_text(stmt, index: 0)
                cattle.cattle_type = tmrsql.sqlite_column_text(stmt, index: 1)
                cattle.cattle_num = tmrsql.sqlite_column_int(stmt, index: 2)
                
                cattle.morning_proportion = tmrsql.sqlite_column_int(stmt, index: 3)
                cattle.nooning_proportion = tmrsql.sqlite_column_int(stmt, index: 4)
                cattle.evening_proportion = tmrsql.sqlite_column_int(stmt, index: 5)
                cattle.cattle_id = tmrsql.sqlite_column_int(stmt, index: 6)
                
                arrM.addObject(cattle)
            }
            tmrsql.sqlite_finalize(stmt)
        }
        return arrM
    }
    
}
