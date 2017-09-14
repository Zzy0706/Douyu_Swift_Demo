//
//  CycleModel.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/14.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    var title : String?
    // 图片
    var tv_pic_url : String?
    // 主播信息对应的字典
    var room : [String : NSObject]?{
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
     var anchor : AnchorModel?
    // MARK:自定义构造函数
    init(dict : [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }

}
