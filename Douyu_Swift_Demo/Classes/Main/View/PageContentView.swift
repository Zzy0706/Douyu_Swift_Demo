//
//  PageContentView.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/11.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit
protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView,progress : CGFloat,sourceIndex : Int,targetIndex : Int)
}
fileprivate let contentCellID = "ContentCellID"
class PageContentView: UIView {
    //MARK:定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentViewController : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delagate : PageContentViewDelegate?
    //MARK :懒加载
    fileprivate lazy var collectionView : UICollectionView = { [weak self] in
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    //MARK :自定义构造函数
    init(frame: CGRect,childVcs : [UIViewController],parentViewController : UIViewController?) {
        self.childVcs = childVcs
        
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK :设置UI界面
extension PageContentView{
    fileprivate func setupUI(){
        //1.将所有的子控制器添加到父控制器中
        for childVc in childVcs{
            parentViewController?.addChildViewController(childVc)
            
        }
        //2.添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

//MARK: 遵守UICollectionViewDataSource协议
extension PageContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(childVcs.count)
        return childVcs.count-1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        //2.添加内容
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}
//MARK: 遵守UICollectionViewDelegate协议
extension PageContentView : UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
    
       startOffsetX = scrollView.contentOffset.x
        
        //print(startOffsetX)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //判断是否为点击事件
        if isForbidScrollDelegate == true {
            return
        }
        //1.获取数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        //2.判断滑动方向
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX {//左滑
            //a.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)//取整得比例
            //b.计算sourceIndex
            sourceIndex = Int(currentOffsetX/scrollViewW)
            //c.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            //d.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW{
                progress = 1
                targetIndex = sourceIndex
            }
        }else{//右滑
            //a.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            //b.计算targetIndex
            targetIndex = Int(currentOffsetX/scrollViewW)
             //c.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex>=childVcs.count {
                sourceIndex = childVcs.count - 1
            }
            
        }
        //3.将progress,targetIndex,sourceIndex 传递给titleView
        //print((progress),(targetIndex), (sourceIndex))
       delagate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
//MARK： 对外提供方法
extension PageContentView{
  public  func setCurrentIndex(currentIndex : Int){
    //1.记住需要禁止执行代理方法
        isForbidScrollDelegate = true
    //2.滚动到正确的位置
        let offsetX = CGFloat(currentIndex)*collectionView.frame.width
        collectionView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: false)
    }
}
