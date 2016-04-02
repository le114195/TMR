//
//  ProcessingView.swift
//  TMR
//
//  Created by 勒俊 on 16/4/2.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class ProcessingView: UIView {

    @IBOutlet weak var currentStatus: UILabel!
    @IBOutlet weak var processingView: UIView!
    @IBOutlet weak var allProcessingView: UIView!
    
    @IBOutlet weak var currentShouldNum: UILabel!
    
    @IBOutlet weak var currentRealityNum: UILabel!
    
    @IBOutlet weak var totalShouldNum: UILabel!
    
    @IBOutlet weak var totalRealityNum: UILabel!
    
    private var model:WorksheetModel!
    
    var closeBlock:(()->())!
    var lastBlock:(()->())!
    private var currentProgress:SDBallProgressView!
    private var totalProgress:SDBallProgressView!
    private var index:Int = 0
    
    override func awakeFromNib() {

        let progressX:CGFloat = (screen_width - 200) * 0.5
        self.currentProgress = SDBallProgressView.init(frame: CGRect.init(x: progressX, y: 100, width: 200, height: 200))
        self.processingView.addSubview(self.currentProgress)
        
        self.totalProgress = SDBallProgressView.init(frame: CGRect.init(x: progressX, y: 100, width: 200, height: 200))
        self.allProcessingView.addSubview(self.totalProgress)
        

    }
    
    
    @IBAction func closeAction(sender: AnyObject) {
        if self.closeBlock != nil {
            self.closeBlock()
        }
    }

    @IBAction func nextAction(sender: AnyObject) {
        
        self.index += 1
        
        if self.index >= self.model.worksheetArray.count {
            if self.lastBlock != nil {
                self.lastBlock()
            }
            return
        }
        self.setStauts()
        
    }
    

    func setModelData(modelData:WorksheetModel) {
        
        self.model = modelData
        self.index = 0
        self.totalShouldNum.text = "\(self.model.allShouldWeight)"
        
        self.setStauts()
    }
    
    private func setStauts() {
    
        let worksheetModel:Worksheet = self.model.worksheetArray[self.index] as! Worksheet
        self.currentStatus.text = "当前加工项：" + worksheetModel.forage_name
        
        self.currentShouldNum.text = "\(worksheetModel.origin_weight)"
        self.currentRealityNum.text = "\(worksheetModel.processed_weight)"
        self.totalRealityNum.text = "\(self.model.allRealityWeight)"
    }
    

}
