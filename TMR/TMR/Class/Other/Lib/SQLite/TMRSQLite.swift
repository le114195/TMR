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
            return true
        }else {
            print("打开数据库失败！！！")
        }
        return false
    }
    
    func sqlite_prepared(sql:String, stmt:UnsafeMutablePointer<COpaquePointer>) -> Int32 {
        return sqlite3_prepare_v2(db, sql.cStringUsingEncoding(NSUTF8StringEncoding)!, -1, stmt, nil)
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
    
    func sqlite_close() -> (Int32) {
        return sqlite3_close(db)
    }
    
    func sqlite_column_text(stmt:COpaquePointer, index:Int32) -> String {
        let xx:UnsafePointer<CChar> = UnsafePointer.init(sqlite3_column_text(stmt, index))
        return String.init(UTF8String: xx)!
    }
    
    func sqlite_column_int(stmt:COpaquePointer, index:Int32) -> Int32 {
        return sqlite3_column_int(stmt, index)
    }
    
    func sqlite_column_double(stmt:COpaquePointer, index:Int32) -> Double {
        return sqlite3_column_double(stmt, index)
    }
    
}




