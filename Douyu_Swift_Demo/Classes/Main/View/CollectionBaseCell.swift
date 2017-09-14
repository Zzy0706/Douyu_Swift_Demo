//
//  CollectionBaseCell.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/14.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //MARK:控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineButton: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    //MARK:定义模型属性
    var anchor : AnchorModel?{
        didSet{
            guard let anchor = anchor else {
                return
            }
            let onlineStr : String?
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online/10000))万在线"
                
            }else{
                onlineStr = "\(String(describing: anchor.online))在线"
            }
            onlineButton.setTitle(onlineStr, for: .normal)
            nickNameLabel.text = anchor.nickname
            iconImageView.kf.setImage(with: URL.init(string: anchor.vertical_src!))
        }
    }
}
