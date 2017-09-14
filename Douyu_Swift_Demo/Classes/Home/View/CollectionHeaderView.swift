//
//  CollectionHeaderView.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/12.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    //MARK:控件属性
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    //MARK:定义模型属性
    var group : AnchorGroup?{
        
        didSet{
            guard let group = group else {
                iconImageView.image = UIImage.init(named: "home_header_phone")
                return
            }
            titleLabel.text = group.tag_name
            iconImageView.image = UIImage.init(named: group.icon_name)
            
        }
    }
}
