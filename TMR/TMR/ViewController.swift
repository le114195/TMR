//
//  ViewController.swift
//  TMR
//
//  Created by 勒俊 on 16/3/27.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var name = String?()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.createSubView()

        
        // Do any additional setup after loading the view, typically from a nib.
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
        }
        
    }
    
    func clickBtn(btn:UIButton) {
        
        
        switch btn.tag {
        case 0:
            
            let processing = TMRProcessing()
            self.navigationController?.pushViewController(processing, animated: true)
            break
        case 1:
            
            let processed = TMRProcessed()
            self.navigationController?.pushViewController(processed, animated: true)
            
            break
        case 2:
            
            let worksheet = TMRWorksheet()
            self.navigationController?.pushViewController(worksheet, animated: true)
            
            break
            
        case 3:
            
            let network = TMRNetwork()
            self.navigationController?.pushViewController(network, animated: true)
            break
            
        default:
            break
        }
    }
}

