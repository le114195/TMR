//
//  ForageManage.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class ForageManage: NSObject {
    
    var forage_name:String = ""
    var forage_id:Int32 = 0
    var repertory:Int32 = 0
    var proportoin:Int32 = 0
    var forage_type:String = ""

    
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
                let forage = ForageManage()
                forage.forage_name = tmrsql.sqlite_column_text(stmt, index: 0)
                forage.forage_id = tmrsql.sqlite_column_int(stmt, index: 1)
                forage.repertory = tmrsql.sqlite_column_int(stmt, index: 2)
                forage.proportoin = tmrsql.sqlite_column_int(stmt, index: 3)
                forage.forage_type = tmrsql.sqlite_column_text(stmt, index: 4)
                arrM.addObject(forage)
            }
            tmrsql.sqlite_finalize(stmt)
        }
        tmrsql.sqlite_close()
        return arrM
    }
    
    
    static func getData(sql:String, oldArray:NSMutableArray) -> NSMutableArray {
        
        let arrM = NSMutableArray()
        var stmt:COpaquePointer = nil
        
        let tmrsql = TMRSQLite()
        
        if !tmrsql.openDatabase() {
            print("打开数据库失败！！！")
        }
        let result = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_OK {
            
            while tmrsql.sqlite_step(stmt) == SQLITE_ROW {
                let forage = ForageManage()
                forage.forage_name = tmrsql.sqlite_column_text(stmt, index: 0)
                forage.forage_id = tmrsql.sqlite_column_int(stmt, index: 1)
                forage.repertory = tmrsql.sqlite_column_int(stmt, index: 2)
                forage.proportoin = tmrsql.sqlite_column_int(stmt, index: 3)
                forage.forage_type = tmrsql.sqlite_column_text(stmt, index: 4)
                var index:Bool = true
                
                for i in 0...oldArray.count-1 {
                    
                    let model:FoundationManage = oldArray[i] as! FoundationManage
                    if model.forage_name == forage.forage_name {
                        index = false
                    }
                }
                if index == true {
                    arrM.addObject(forage)
                }
            }
            tmrsql.sqlite_finalize(stmt)
        }
        tmrsql.sqlite_close()
        return arrM
    }
    
    
}
