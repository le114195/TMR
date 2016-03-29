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
    
    var lock = NSLock()
    

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
    
    
    func updateData(sql:String) {

        self.openDatabase()
        var stmt:COpaquePointer = nil
        var result:Int32 = self.sqlite_prepared(sql, stmt: &stmt)
        if result == SQLITE_ERROR {
            print("sqlite_prepared error!!!")
            return
        }
        result = self.sqlite_step(stmt)
        self.sqlite_finalize(stmt)
        
        if result == SQLITE_ERROR {
            print("sqlite_step error")
        }
        self.sqlite_close()
    }
    
}




