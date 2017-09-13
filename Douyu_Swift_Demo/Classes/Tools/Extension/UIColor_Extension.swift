//
//  UIColor_Extension.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/11.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit
extension UIColor{
  convenience  init(r : CGFloat , g :CGFloat ,b :CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
