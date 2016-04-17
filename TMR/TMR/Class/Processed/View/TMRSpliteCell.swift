//
//  TMRSpliteCell.swift
//  TMR
//
//  Created by 勒俊 on 16/4/17.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRSpliteCell: UITableViewCell, UITextFieldDelegate {

    
    @IBOutlet weak var worksheetName: UILabel!
    
    @IBOutlet weak var proportion: UITextField!
    
    var proportionNum:Int = 0
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.proportion.delegate = self
        self.selectionStyle = UITableViewCellSelectionStyle.None
        // Initialization code
    }

    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        if Int(self.proportion.text!) != nil {
            self.proportionNum = Int(self.proportion.text!)!
        }
        
    }
    
    
}
