//
//  ForageAddView.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class ForageAddView: UIView {
    
    var isAdd:Bool?
    
    
    var forage:ForageManage?
    
    var cancelBlock:(()->())?
    var sureBlock:((forage:ForageManage)->())?
    
    @IBOutlet weak var forageName: UITextField!
    @IBOutlet weak var forageID: UITextField!
    @IBOutlet weak var repository: UITextField!
    @IBOutlet weak var forage_type: UITextField!
    
    
    @IBAction func cancel(sender: AnyObject) {
        
        if (cancelBlock != nil) {
            cancelBlock!()
        }
    }
    
    
    @IBAction func sure(sender: AnyObject) {

        if forage == nil {
            forage = ForageManage()
        }
        
        forage!.forage_name = forageName.text!
        forage!.forage_id = Int32(forageID.text!)!
        forage!.repertory = Int32(repository.text!)!
        forage!.forage_type = forage_type.text!
        
        if (sureBlock != nil) {
            sureBlock!(forage: forage!)
        }
        
        if isAdd == true {
            
            self.insertData(forage!)
            
        }else {
            
        }
        
    }
    
    private func insertData(model:ForageManage){
        
        let tmrsql = TMRSQLite()
        tmrsql.openDatabase()
        
        var stmt:COpaquePointer = nil
        
        let sql = "insert into forage_manage (forage_name, forage_id, repertory, proportion, forage_type) values (?, ?, ?, ?, ?)"
        var result:Int32 = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_ERROR {
            print("sqlite_prepared error!!!")
            return
        }
        
        tmrsql.sqlite_bind_text(stmt, index: 1, param: model.forage_name)
        tmrsql.sqlite_bind_int(stmt, index: 2, param: model.forage_id)
        tmrsql.sqlite_bind_int(stmt, index: 3, param: model.repertory)
        tmrsql.sqlite_bind_int(stmt, index: 4, param: model.proportoin)
        tmrsql.sqlite_bind_text(stmt, index: 5, param: model.forage_type)
        
        result = tmrsql.sqlite_step(stmt)
        tmrsql.sqlite_finalize(stmt)
        
        if result == SQLITE_ERROR {
            print("sqlite_step error")
        }
        
        tmrsql.sqlite_close()
        
    }
    
    
    
    
}
