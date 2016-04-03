//
//  TMRHintView.swift
//  TMR
//
//  Created by 勒俊 on 16/4/1.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRHintView: UIView {

    var showLabel:UILabel!
    
    let time: NSTimeInterval = 1.5
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        
        
        

    }
    
    
    
    private func createLabel(str:NSString){
        
        self.showLabel = UILabel()
        self.showLabel.font = UIFont.systemFontOfSize(13.0)
        let rect = str.boundingRectWithSize(CGSize.init(width: 200, height: 1000.0), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: NSDictionary(object: UIFont.systemFontOfSize(13.0), forKey: NSFontAttributeName) as? [String : AnyObject], context: nil)
        self.showLabel.frame = CGRect.init(x: (screen_width - (rect.size.width + 10)) * 0.5, y: (screen_height - 60) * 0.5, width: rect.size.width + 10, height: 60)

        self.showLabel.textColor = UIColor.whiteColor()
        
        self.showLabel.layer.cornerRadius = 30.0
        
        self.showLabel.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)
        self.showLabel.alpha = 0
        self.showLabel.textAlignment = NSTextAlignment.Center

        self.addSubview(self.showLabel)
        
    }
    
    static func show(title:String, view:UIView) {
        
        let show = TMRHintView.init(frame: CGRect.init(x: 0, y: 0, width: screen_width, height: screen_height))
        
        show.createLabel(title)
        
        view.addSubview(show)
        show.showLabel.text = title
        
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(show.time * Double(NSEC_PER_SEC)))
        UIView.animateWithDuration(0.25, animations: { 
            
            show.showLabel.alpha = 0.99
            
            }) { (true) in
                dispatch_after(delay, dispatch_get_main_queue()) {
                    
                    UIView.animateWithDuration(0.25, animations: { 
                        show.showLabel.alpha = 0
                        }, completion: { (true) in
                            show.removeFromSuperview()
                    })
                    
                }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
