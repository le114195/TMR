//
//  CattleView.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class CattleView: UIView {
    
    var cancelBlock:(()->())!
    var sureBlock:((model:CattleManage)->())!
    
    
    @IBOutlet weak var cattle_name: UITextField!
    
    @IBOutlet weak var cattle_type: UITextField!
    
    @IBOutlet weak var cattle_num: UITextField!
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        if cancelBlock != nil {
            cancelBlock()
        }
    }
    
    @IBAction func sureAction(sender: AnyObject) {
        
        let model = CattleManage()
        model.morning_proportion = 0
        model.nooning_proportion = 0
        model.evening_proportion = 0
        model.cattle_name = self.cattle_name.text!
        model.cattle_num = Int32(self.cattle_num.text!)!
        model.cattle_type = self.cattle_type.text!

        if sureBlock != nil {
            sureBlock(model: model)
        }
        
        self.insertData(model)
    }
    
    private func insertData(model:CattleManage){
        
        let tmrsql = TMRSQLite()
        tmrsql.openDatabase()
        
        var stmt:COpaquePointer = nil
        
        let sql = "insert into cattle_manage (cattle_name, cattle_type, cattle_num, morning_proportion, nooning_proportion, evening_proportion) values (?, ?, ?, ?, ?, ?)"
        var result:Int32 = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_ERROR {
            print("sqlite_prepared error!!!")
            return
        }
        
        tmrsql.sqlite_bind_text(stmt, index: 1, param: model.cattle_name)
        tmrsql.sqlite_bind_text(stmt, index: 2, param: model.cattle_type)
        tmrsql.sqlite_bind_int(stmt, index: 3, param: model.cattle_num)
        tmrsql.sqlite_bind_int(stmt, index: 4, param: model.morning_proportion)
        tmrsql.sqlite_bind_int(stmt, index: 5, param: model.nooning_proportion)
        tmrsql.sqlite_bind_int(stmt, index: 6, param: model.evening_proportion)
        
        result = tmrsql.sqlite_step(stmt)
        tmrsql.sqlite_finalize(stmt)
        
        if result == SQLITE_ERROR {
            print("sqlite_step error")
        }
        tmrsql.sqlite_close()
    }
    
    
    
    
 
}
