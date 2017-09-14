//
//  CollectionPrettyCell.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/12.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionBaseCell {
    //MARK:控件属性
    @IBOutlet weak var cityButton: UIButton!

    //MARK:定义模型属性
   override var anchor : AnchorModel?{
        didSet{
            
         super.anchor = anchor
         cityButton.setTitle(anchor?.anchor_city, for: .normal)
          
        }
    }

}
