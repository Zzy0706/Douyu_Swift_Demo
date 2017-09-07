//
//  UIBarButtonItem_Extension.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/7.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
   /* class func creatItem(imageName : String, highImageName : String , size : CGSize) -> UIBarButtonItem{
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        btn.frame = CGRect.init(origin: .zero, size: size)
        
        return UIBarButtonItem.init(customView: btn)
    }
 */
    
    //便利构造函数 1.convenience开头 2.在构造函数中必须明确调用一个设计的构造函数(self)
    
     convenience init(imageName : String, highImageName : String = "", size : CGSize = .zero) {//设置默认参数
        
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        if size == .zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect.init(origin: .zero, size: size)
        }
        
        self.init(customView: btn)
    }
}
