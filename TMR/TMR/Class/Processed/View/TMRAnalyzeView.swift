//
//  TMRAnalyzeView.swift
//  TMR
//
//  Created by 勒俊 on 16/4/14.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRAnalyzeView: UIView {

    var closeBlock:(()->())!
    var arrayData = NSMutableArray()
    var dateArray = NSMutableArray()
    
    lazy private var diffScrollView:UIScrollView = {
        
        let diffScr = UIScrollView.init(frame: CGRect.init(x: 0, y: 64, width: screen_width, height: 330))
        diffScr.contentSize = CGSize.init(width: screen_width * CGFloat(self.arrayData.count) / 4, height: 330)
        diffScr.backgroundColor = UIColor.whiteColor()
        self.addSubview(diffScr)
        
        let diffAnalyze = AnalyzeDifference()
        diffAnalyze.frame = CGRect.init(x: 0, y: 0, width: screen_width * CGFloat(self.arrayData.count) / 4, height: 150)
        diffAnalyze.setDataModel(self.arrayData)
        diffScr.addSubview(diffAnalyze)
        
        let percent = AnalyzePercent()
        percent.frame = CGRect.init(x: 0, y: 150, width: screen_width * CGFloat(self.arrayData.count) / 4, height: 150)
        percent.setDataModel(self.arrayData)
        diffScr.addSubview(percent)
        
        
        return diffScr
    }()
    

    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor()
        let closeBtn = UIButton.init(frame: CGRect.init(x: 70, y: screen_height - 70, width: screen_width - 140, height: 44))
        closeBtn.addTarget(self, action: #selector(TMRAnalyzeView.closeAction), forControlEvents: UIControlEvents.TouchUpInside)
        closeBtn.setTitle("关闭", forState: UIControlState.Normal)
        closeBtn.backgroundColor = UIColor.blueColor()
        self.addSubview(closeBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func closeAction() {
        
        if self.closeBlock != nil {
            self.closeBlock()
        }
    }
    
    
    func setDataModel(model:NSMutableArray, dateArray:NSMutableArray) {
        
        self.arrayData = model
        self.dateArray = dateArray
        
        for i in 0...dateArray.count-1 {
            
            let label = UILabel.init(frame: CGRect.init(x: screen_width * 0.25 * CGFloat(i), y: 330 - 30, width: screen_width * 0.25, height: 30))
            label.text = dateArray[i] as? String
            label.font = UIFont.systemFontOfSize(11)
            label.textAlignment = NSTextAlignment.Center
            self.diffScrollView.addSubview(label)
        }
    }
}
