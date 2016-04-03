//
//  TMRProcessingCell.swift
//  TMR
//
//  Created by 勒俊 on 16/4/2.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRProcessingCell: UITableViewCell {

    @IBOutlet weak var worksheetTitle: UILabel!
    @IBOutlet weak var shouldNum: UILabel!
    @IBOutlet weak var realityNum: UILabel!
    
    private var model:WorksheetModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setModelData(modelData:WorksheetModel) {
        
        self.worksheetTitle.text = modelData.sheet_name
        self.shouldNum.text = NSString(format: "%.2f", modelData.allShouldWeight) as String
        self.realityNum.text = NSString(format: "%.2f", modelData.allRealityWeight) as String
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
