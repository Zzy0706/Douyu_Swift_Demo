//
//  RecommendCycleView.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/14.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit
fileprivate let kCycleCellID =  "kCycleCellID"
class RecommendCycleView: UIView {
    //MARK:定义属性
    var cycleModels :[CycleModel]?{
        didSet{
            collectionView.reloadData()
            
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }
    //MARK:控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = .init(rawValue: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        //注册cell
        collectionView.register(UINib.init(nibName: "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
        
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
    }

}
//MARK:提供一个快快速创建View的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

//MARK:遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item]
        
        
        return cell
    }
}
//MARK:遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动偏移量
        let offSetX = scrollView.contentOffset.x
        
        pageControl.currentPage = Int(offSetX / scrollView.bounds.width+0.5)
        
    }
}
