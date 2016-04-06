//
//  ProcessedDetailCell.swift
//  TMR
//
//  Created by 勒俊 on 16/4/6.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class ProcessedDetailCell: UITableViewCell {

    
    @IBOutlet weak var forgaeName: UILabel!
    
    @IBOutlet weak var originWeight: UILabel!
    
    
    @IBOutlet weak var processedWeight: UILabel!
    
    @IBOutlet weak var percent: UILabel!
    
    var model:Worksheet!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataModel(dataModel:Worksheet) {
        
        self.model = dataModel
        self.forgaeName.text = dataModel.forage_name
        self.originWeight.text = NSString(format: "%.2f", dataModel.origin_weight) as String
        self.processedWeight.text = NSString(format: "%.2f", dataModel.processed_weight) as String
        
        self.percent.text = dataModel.percent
        
    }
    
    
    
    
}
