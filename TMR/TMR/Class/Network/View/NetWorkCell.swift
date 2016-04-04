//
//  NetWorkCell.swift
//  TMR
//
//  Created by 勒俊 on 16/4/3.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetWorkCell: UITableViewCell {

    
    @IBOutlet weak var worksheetName: UILabel!
    
    @IBOutlet weak var uploadBtn: UIButton!
    
    var successBlock:(()->())!
    
    var uploadBlock:(()->())!
    
    var date:String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.uploadBtn.layer.cornerRadius = 5
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        // Initialization code
    }

    func setModelData(model:String) {
        self.date = model
        self.worksheetName.text = self.date
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    @IBAction func uploadAction(sender: AnyObject) {
        
        
        if self.uploadBlock != nil {
            self.uploadBlock()
        }
        
                
    }
    
}
