//
//  CattleManageCell.swift
//  TMR
//
//  Created by 勒俊 on 16/3/28.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class CattleManageCell: UITableViewCell {

    @IBOutlet weak var cattle_name: UILabel!
    
    @IBOutlet weak var cattle_type: UILabel!
    
    @IBOutlet weak var cattle_num: UILabel!
    
    var cattle:CattleManage!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setModel(model:CattleManage) {
        
        self.cattle = model
        
        self.cattle_num.text = String(model.cattle_num)
        self.cattle_name.text = model.cattle_name
        self.cattle_type.text = model.cattle_type
        
    }
    
}
