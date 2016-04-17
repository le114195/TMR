//
//  TMROriginListCell.swift
//  TMR
//
//  Created by 勒俊 on 16/4/15.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMROriginListCell: UITableViewCell {

    @IBOutlet weak var worksheetName: UILabel!
    
    @IBOutlet weak var origin_weight: UILabel!
    
    
    @IBOutlet weak var button: UIButton!
    
    var clickBtvBlock:(()->())!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.button.hidden = true
        
        // Initialization code
    }
    
    func setModelData(modelData:WorksheetModel) {
        
        self.worksheetName.text = modelData.sheet_name
        self.origin_weight.text = "应加工数：" +  (NSString(format: "%.2f", modelData.allShouldWeight) as String) as String
    }
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    
    @IBAction func btnAction(sender: AnyObject) {
        
        if clickBtvBlock != nil {
            self.clickBtvBlock()
        }
        
    }
    

    
    
    
}
