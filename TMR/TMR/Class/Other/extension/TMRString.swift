//
//  TMRString.swift
//  TMR
//
//  Created by 勒俊 on 16/4/1.
//  Copyright © 2016年 勒俊. All rights reserved.
//

import Foundation


extension String {

    func converStringToInt32() -> Int32 {
        
        if Int32(self) == nil {
            return 0
        }else {
            return Int32(self)!
        }
    }
    
    func converStringToDouble() -> Double {
        if Double(self) == nil {
            return 0
        }else {
            return Double(self)!
        }
    }

}
