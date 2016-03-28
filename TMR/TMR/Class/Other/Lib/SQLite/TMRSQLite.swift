//
//  TMRSQLite.swift
//  TMR
//
//  Created by 勒俊 on 16/3/27.
//  Copyright © 2016年 勒俊. All rights reserved.
//


import UIKit

let sqlite_path = NSHomeDirectory().stringByAppendingString("/Library/Caches/worksheet.db")

class TMRSQLite: NSObject {

    var db:COpaquePointer = nil
    
    func openDatabase() -> Bool {
        if sqlite3_open(sqlite_path, &db) == SQLITE_OK {
            print("open sqlite3 success!!!")
            return true
        }
        return false
    }
    
    func sqlite_prepared(sql:String) -> COpaquePointer {
        
        var stmt:COpaquePointer = nil
        
        if sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, &stmt, nil) == SQLITE_OK {
            return stmt
        }

        return stmt
    }
    
    
    func sqlite_bind_text(stmt:COpaquePointer, index:Int32, param:String) {
        sqlite3_bind_text(stmt, index, param.cStringUsingEncoding(NSUTF8StringEncoding)!, -1) { (SQLITE_TRANSIENT) in
        }
    }
    
    func sqlite_bind_int(stmt:COpaquePointer, index:Int32, param:Int32) {
        sqlite3_bind_int(stmt, index, param)
    }
    
    func sqlite_bind_double(stmt:COpaquePointer, index:Int32, param:Double) {
        sqlite3_bind_double(stmt, index, param)
    }
    
    func sqlite_step(stmt:COpaquePointer) -> (Int32) {
        return sqlite3_step(stmt)
    }
    
    func sqlite_finalize(stmt:COpaquePointer) -> (Int32) {
        return sqlite3_finalize(stmt)
    }
    
    func sqlite_close(db:COpaquePointer) -> (Int32) {
        return sqlite3_close(db)
    }
    
    
    
}


















