//
//  TMRWorksheet.swift
//  TMR
//
//  Created by 勒俊 on 16/3/27.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class TMRWorksheet: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.createSubView()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    private func createSubView() {
        
        let height:CGFloat = (screen_height - 64) / 4
        
        for i in 0...3{
            let btny:CGFloat = 64 + CGFloat(i) * height;
            let btn1 = UIButton.init(frame: CGRect.init(x: 0, y: btny, width: screen_width, height: height - 1))
            btn1.tag = i
            
            btn1.backgroundColor = UIColor.blueColor()
            
            btn1.layer.cornerRadius = 5
            
            btn1.addTarget(self, action: #selector(ViewController.clickBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.view.addSubview(btn1)
            
            btn1.titleLabel?.font = UIFont.systemFontOfSize(34)
            
            switch i {
            case 0:
                btn1.setTitle("草料管理", forState: UIControlState.Normal)
                break
                
            case 1:
                btn1.setTitle("牛群管理", forState: UIControlState.Normal)
                break
                
            case 2:
                btn1.setTitle("基础配方", forState: UIControlState.Normal)
                break
                
            case 3:
                btn1.setTitle("制作加工单", forState: UIControlState.Normal)
                break
            default:
                break
            }
        }
    }
    
    func clickBtn(btn:UIButton){
        
        switch btn.tag {
        case 0:
            
            break
            
        case 1:
            
            break
            
        case 2:
            
            break
            
        case 3:
            
            break
            
            
        default:
            break
        }
        
        
    }
    
    

}
