//
//  CattleManageDetailCell.swift
//  TMR
//
//  Created by 勒俊 on 16/3/29.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class CattleManageDetailCell: UITableViewCell {

    
    @IBOutlet weak var forage_name: UILabel!
    
    @IBOutlet weak var forage_type: UILabel!
    
    @IBOutlet weak var forage_weight: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.endEditing(true)
        
    }
    
    
}
