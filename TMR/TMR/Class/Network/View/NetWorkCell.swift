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
        
        
        let sql:String = "select * from work_sheet where status=1 and uploadStatus=0 and date='\(self.date)'"
        let jsonObject: AnyObject = Worksheet.getJsonData(sql)
        Alamofire.request(.POST, "http://localhost:8080/TestMysql/Demo1", parameters: ["foo": "gg", "data":jsonObject])
            .responseJSON { response in
                if response.result.isSuccess {
                    print("上传成功！！！")
                }

        }
        
    }
    
    
    
}
