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
    var showText:(()->())!
    var showError:(()->())!
    
    @IBOutlet weak var forageName: UITextField!
    @IBOutlet weak var forageID: UITextField!

    @IBOutlet weak var proportoin: UITextField!
    
    
    @IBOutlet weak var forage_type: UITextField!
    
    @IBAction func cancel(sender: AnyObject) {
        
        if (cancelBlock != nil) {
            cancelBlock!()
        }
        self.endEditing(true)
    }
    
    @IBAction func sure(sender: AnyObject) {
        
        if self.forageName.text?.characters.count == 0 ||
             self.forageID.text?.characters.count == 0 ||
           self.proportoin.text?.characters.count == 0 ||
        self.forage_type.text?.characters.count == 0
        {
            
            if self.showText != nil {
                self.showText()
            }
            return
        }
        
        if Int32(self.forageID.text!) == nil ||
            Double(self.proportoin.text!) == nil
        {
            if self.showError != nil {
                self.showError()
            }
            return
        }
        
        
        
        if forage == nil {
            forage = ForageManage()
        }
        self.endEditing(true)
        forage!.proportoin = Int32(proportoin.text!)!
        if isAdd == true {
            forage!.forage_name = forageName.text!
            forage!.forage_id = Int32(forageID.text!)!
            forage!.forage_type = forage_type.text!
            self.insertData(forage!)
        }else if isAdd == false {
            let sql = "update forage_manage set proportion=\(forage!.proportoin) where forage_id=\(forage!.forage_id)"
            TMRSQLite().updateData(sql)
        }
        
        if (sureBlock != nil) {
            sureBlock!(forage: forage!)
        }
    }
    
    override func awakeFromNib() {
        
        self.forageName.keyboardType = UIKeyboardType.Default
        self.forageID.keyboardType = UIKeyboardType.NumberPad
        self.forage_type.keyboardType = UIKeyboardType.Default
        self.proportoin.keyboardType = UIKeyboardType.NumberPad
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
        self.proportoin.text = String(model.proportoin)
        
    }
    
    func clearData() {
        self.forageName.text = ""
        self.forageID.text = ""
        self.forage_type.text = ""
        self.proportoin.text = ""
    }
    
    
}
