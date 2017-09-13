//
//  NSDate_Extension.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/12.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit


extension NSDate{
    class func getCurrentTime() -> String{
        let nowDate = NSDate.init()
        let intervarl =  Int(nowDate.timeIntervalSince1970)
        return "\(intervarl)"
    }
}
