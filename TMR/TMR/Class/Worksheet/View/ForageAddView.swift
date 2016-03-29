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
        
        forage!.repertory = Int32(repository.text!)!
        if isAdd == true {
            forage!.forage_name = forageName.text!
            forage!.forage_id = Int32(forageID.text!)!
            forage!.forage_type = forage_type.text!
            self.insertData(forage!)
        }else if isAdd == false {
            let sql = "update forage_manage set repertory=\(forage!.repertory) where forage_id=\(forage!.forage_id)"
            TMRSQLite().updateData(sql)
        }
        
        if (sureBlock != nil) {
            sureBlock!(forage: forage!)
        }
        
    }
    
    private func insertData(model:ForageManage){
        
        let tmrsql = TMRSQLite()
        tmrsql.openDatabase()
        var stmt:COpaquePointer = nil
        let sql = "insert into forage_manage (forage_name, forage_id, repertory, proportion, forage_type) values ('\(model.forage_name)', \(model.forage_id), \(model.repertory), \(model.proportoin), '\(model.forage_type)')"
        var result:Int32 = tmrsql.sqlite_prepared(sql, stmt: &stmt)
        
        if result == SQLITE_ERROR {
            print("sqlite_prepared error!!!")
            return
        }
        
        result = tmrsql.sqlite_step(stmt)
        tmrsql.sqlite_finalize(stmt)
        
        if result == SQLITE_ERROR {
            print("sqlite_step error")
        }
        tmrsql.sqlite_close()

    }
    
    func setModel(model:ForageManage) {
        
        self.forage = model
        self.forageName.text = model.forage_name
        self.forageID.text = String(model.forage_id)
        self.forage_type.text = model.forage_type
        self.repository.text = String(model.repertory)
    }
    
    func clearData() {
        self.forageName.text = ""
        self.forageID.text = ""
        self.forage_type.text = ""
        self.repository.text = ""
    }
    
    
}
