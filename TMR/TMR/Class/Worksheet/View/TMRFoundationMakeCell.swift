//
//  TMRFoundationMakeCell.swift
//  TMR
//
//  Created by 勒俊 on 16/3/31.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRFoundationMakeCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var cattle_name: UILabel!
    
    @IBOutlet weak var morning: UITextField!
    
    @IBOutlet weak var nooning: UITextField!
    
    @IBOutlet weak var evening: UITextField!
    
    var didselectEdit:((indexPath:NSIndexPath)->())!
    var indexPath:NSIndexPath!
    
    var model:CattleManage!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.morning.delegate = self
        self.nooning.delegate = self
        self.evening.delegate = self
        
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataModel(dataModel:CattleManage) {
        self.model = dataModel
        self.cattle_name.text = dataModel.cattle_name
        self.morning.text = "\(dataModel.morning_proportion)"
        self.nooning.text = "\(dataModel.nooning_proportion)"
        self.evening.text = "\(dataModel.evening_proportion)"
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if self.didselectEdit != nil {
            self.didselectEdit(indexPath: self.indexPath)
        }
        
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        var sql:String = ""
        var proportion:Int32 = 0
        
        
        
        if textField.isEqual(self.morning) {
            
            proportion = Int32(self.morning.text!)!
            sql = "update cattle_manage set morning_proportion=\(proportion) where cattle_name='\(self.model.cattle_name)'"
            TMRSQLite().updateData(sql)
        }else if textField.isEqual(self.nooning) {
            proportion = Int32(self.nooning.text!)!
            sql = "update cattle_manage set nooning_proportion=\(proportion) where cattle_name='\(self.model.cattle_name)'"
            TMRSQLite().updateData(sql)
        }else if textField.isEqual(self.evening) {
            
            proportion = Int32(self.evening.text!)!
            sql = "update cattle_manage set evening_proportion=\(proportion) where cattle_name='\(self.model.cattle_name)'"
            TMRSQLite().updateData(sql)
        }
        
        
    }
    
    
}
