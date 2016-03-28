//
//  ForageManageCell.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class ForageManageCell: UITableViewCell {
    
    @IBOutlet weak var forageName: UILabel!
    
    @IBOutlet weak var forageID: UILabel!
    
    @IBOutlet weak var repository: UILabel!
    
    @IBOutlet weak var forage_type: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        // Initialization code
    }
    
    
    func setModel(model:ForageManage) {
        forageName.text = model.forage_name
        forageID.text = String(model.forage_id)
        repository.text = String(model.repertory)
        forage_type.text = model.forage_type
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
