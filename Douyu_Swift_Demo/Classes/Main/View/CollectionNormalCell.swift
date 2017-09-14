//
//  CollectionNormalCell.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/12.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {
    //MARK:控件属性

    @IBOutlet weak var roomNameLabel: UILabel!
    //MARK:定义模型属性
  override  var anchor : AnchorModel?{
        didSet{
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
            
           
        }
    }

}
