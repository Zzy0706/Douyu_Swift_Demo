//
//  AnchorModel.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/12.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    var room_id : Int = 0//房间ID
    var vertical_src : String?//房间图片地址
    var isVertical :  Int = 0 //判断是否为手机直播 0表示电脑 1表示手机直播
    var room_name : String?//房间名称
    var nickname : String?//主播昵称
    var online : Int = 0 //观看人数
    var anchor_city : String? //所在城市
    init(dict:[String:NSObject]){
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
