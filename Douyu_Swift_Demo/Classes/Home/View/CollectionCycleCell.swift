//
//  CollectionCycleCell.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/14.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    //MARK:控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    //MARK:定义模型属性
    var cycleModel : CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            iconImageView.kf.setImage(with: URL.init(string: cycleModel?.tv_pic_url ?? "Img_default"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
