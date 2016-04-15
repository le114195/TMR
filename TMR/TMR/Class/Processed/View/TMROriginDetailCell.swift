//
//  TMROriginDetailCell.swift
//  TMR
//
//  Created by 勒俊 on 16/4/15.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMROriginDetailCell: UITableViewCell, UITextFieldDelegate {

    
    @IBOutlet weak var forage_name: UILabel!
    
    @IBOutlet weak var origin_weight: UITextField!
    var didselectEdit:((indexPath:NSIndexPath)->())!
    var indexPath:NSIndexPath!
    
    private var workModel:Worksheet!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.origin_weight.delegate = self
        
              
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setModel(model:Worksheet) {
        
        self.workModel = model
        
        self.forage_name.text = model.forage_name
        self.origin_weight.text = "\(model.origin_weight)"
        
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if Double(self.origin_weight.text!) != nil {
            self.workModel.origin_weight = Double(self.origin_weight.text!)!
        }else {
            self.origin_weight.text = "\(self.workModel.origin_weight)"
            return
        }
        let sql = "update work_sheet set originWeight=\(self.workModel.origin_weight) where worksheet_id=\(self.workModel.worksheet_id)"
        TMRSQLite().updateData(sql)
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if self.didselectEdit != nil {
            self.didselectEdit(indexPath: self.indexPath)
        }
        
    }
    
}
