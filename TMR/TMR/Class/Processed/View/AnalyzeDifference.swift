//
//  AnalyzeDifference.swift
//  TMR
//
//  Created by 勒俊 on 16/4/14.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class AnalyzeDifference: UIView {

    var arrayData = NSMutableArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setDataModel(model:NSMutableArray) {
        
        self.arrayData = model
        
    }
    
    
    override func drawRect(rect: CGRect) {
        
        self.test1()
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1)
        CGContextSetLineWidth(context, 1)
        CGContextMoveToPoint(context, 0, 75)
        var x:CGFloat = 0
        //        CGContextAddLineToPoint(context, 100, 200)
        for i in 0...self.arrayData.count-1 {
            
            let arrM:NSMutableArray = self.arrayData[i] as! NSMutableArray
            
            for j in 0...arrM.count - 1 {
                
                x += screen_width * 0.25 / CGFloat(arrM.count)
                let dict:NSMutableDictionary = arrM[j] as! NSMutableDictionary
                let difference:Double = dict.valueForKey("difference") as! Double
                CGContextAddLineToPoint(context, x, 75 + CGFloat(difference * 10))
            }
        }
        CGContextStrokePath(context)
        
    }
    
    
    private func test1() {
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.5)
        CGContextSetRGBStrokeColor(context, 0.99, 0, 0, 1)
        CGContextMoveToPoint(context, 0, 75)
        CGContextAddLineToPoint(context, 500, 75)
        CGContextStrokePath(context)
    }
    


}
