//
//  FoundationMakeCell.swift
//  TMR
//
//  Created by 勒俊 on 16/3/29.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class FoundationMakeCell: UITableViewCell {

    var model:ForageManage!
    
    @IBOutlet weak var forage_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataModel(dataModel:ForageManage) {
        self.model = dataModel
        self.forage_name.text = dataModel.forage_name
    }
    
    
    
}
