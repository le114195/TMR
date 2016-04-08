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
    
    var updateTime:NSTimer!
    
    private var currentWeight:Double = 0
    private var currentTotalWeight:Double = 0
    private var currentOriginWeight:Double = 0

    private var model:WorksheetModel!
    private var worksheet:Worksheet!
    
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
        self.updateTime.invalidate()
    }

    @IBAction func nextAction(sender: AnyObject) {
        self.index += 1
        
        self.updateDataToDB()
        
        
        
        if self.index >= self.model.worksheetArray.count {
            self.updateTime.invalidate()
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
        self.currentTotalWeight = self.model.allRealityWeight
        self.setStauts()
    }
    
    private func setStauts() {
    
        self.worksheet = self.model.worksheetArray[self.index] as! Worksheet
        self.currentStatus.text = "当前加工项：" + self.worksheet.forage_name
        
        self.currentShouldNum.text = "\(self.worksheet.origin_weight)"
        self.currentRealityNum.text = "\(self.worksheet.processed_weight)"
        self.totalRealityNum.text = "\(self.model.allRealityWeight)"
        
        self.currentWeight = self.worksheet.processed_weight
        self.currentOriginWeight = self.worksheet.origin_weight
    }
    
    func startUpdateData() {
        self.updateTime = NSTimer.init(timeInterval: 0.1, target: self, selector: #selector(ProcessingView.updateData), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(self.updateTime, forMode: NSRunLoopCommonModes)
    }
    
    func updateData() {
        
        if self.currentOriginWeight < 10 {
            self.currentWeight += self.currentOriginWeight * 0.04
            self.currentTotalWeight += self.currentOriginWeight * 0.04
        }else if self.currentOriginWeight < 50 {
            self.currentWeight += self.currentOriginWeight * 0.02
            self.currentTotalWeight += self.currentOriginWeight * 0.02
        }else {
            self.currentWeight += self.currentOriginWeight * 0.01
            self.currentTotalWeight += self.currentOriginWeight * 0.01
        }
        
        self.currentRealityNum.text = NSString(format: "%.2f", self.currentWeight) as String
        self.totalRealityNum.text = NSString(format: "%.2f", self.currentTotalWeight) as String
        
        self.currentProgress.progress = CGFloat(self.currentWeight) / CGFloat(self.currentOriginWeight)
        self.totalProgress.progress = CGFloat(self.currentTotalWeight) / CGFloat(self.model.allShouldWeight)
        
    }
    
    private func updateDataToDB(){
        
        self.worksheet.processed_weight = self.currentWeight
        self.worksheet.status = 1
        self.worksheet.percent = NSString(format: "%.0f", self.currentWeight / self.worksheet.origin_weight * 100) as String + "%"
        self.model.allRealityWeight = self.currentTotalWeight
        let sql = "update work_sheet set processedWeight=\(self.worksheet.processed_weight), percent='\(self.worksheet.percent)', status=1 where worksheet_id=\(self.worksheet.worksheet_id) and facilityID='\(facilityID)'"
        TMRSQLite().updateData(sql)
    }
    
}
