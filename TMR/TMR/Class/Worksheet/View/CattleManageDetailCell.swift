//
//  CattleManageDetailCell.swift
//  TMR
//
//  Created by 勒俊 on 16/3/29.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class CattleManageDetailCell: UITableViewCell, UITextFieldDelegate {

    
    @IBOutlet weak var forage_name: UILabel!
    @IBOutlet weak var forage_type: UILabel!
    @IBOutlet weak var forage_weight: UITextField!
    var oldValue:Double = 0
    
    var didselectEdit:((indexPath:NSIndexPath)->())!
    var indexPath:NSIndexPath!
    
    var model:FoundationManage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.forage_weight.delegate = self
                // Initialization code
    }

    func setDataModel(dataModel:FoundationManage) {
        
        self.model = dataModel
        
        self.forage_name.text = model?.forage_name
        self.forage_type.text = model?.forage_type
        self.forage_weight.text = "\(model.forage_weight)"
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.endEditing(true)
        
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.model.forage_weight = Double(self.forage_weight.text!)!
        let sql = "update foundation_manage set forage_weight=\(model.forage_weight) where forage_name='\(model.forage_name)'"
        TMRSQLite().updateData(sql)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if self.didselectEdit != nil {
            self.didselectEdit(indexPath: self.indexPath)
        }
        
    }
    
}
