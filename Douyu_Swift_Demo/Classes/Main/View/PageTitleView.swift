//
//  PageTitleView.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/7.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit
//MARK:定义协议
protocol PageTitleViewDelegate : class {
    func pageTitleView (titleView : PageTitleView,selectedIndex index : Int)
}
//MARK:定义常亮
fileprivate let kScrollLineH : CGFloat = 2
fileprivate let kNormarlColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
fileprivate let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)

class PageTitleView: UIView {
    //MARK:- 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : PageTitleViewDelegate?
    //MARK: 拉懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView.init()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false//不超过内容
        
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
       let scrollLine = UIView.init()
        scrollLine.backgroundColor = UIColor.orange
        
        return scrollLine
    }()
    //MARK:- 自定义构造函数
    
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        //MARK :设置UI界面
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
//MARK :设置UI界面
extension PageTitleView{
    fileprivate func setUpUI(){
        //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = bounds
        //2.添加label
        setupTitleLabel()
        
        //3.设置底端线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    fileprivate func setupTitleLabel(){
        let labelW : CGFloat =  frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        for(index,title) in titles.enumerated(){
            //1.创建label
            let label = UILabel.init()
            //2.设置label属性
            label.text = title
            label.tag = index
            
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.init(r: kNormarlColor.0, g: kNormarlColor.1, b: kNormarlColor.2)
            label.textAlignment = .center
            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect.init(x: labelX, y: labelY, width: labelW, height: labelH)
           //4.将label添加到scroView中
            scrollView.addSubview(label)
            titleLabels.append(label)
           //5.给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer.init(target: self, action:#selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
            
        }
    }
    
    fileprivate func setupBottomMenuAndScrollLine(){
        //1.添加底线
        let bottomLine = UIView.init()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect.init(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
            //a.获取第一个label
       guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame =  CGRect.init(x: firstLabel.frame.origin.x, y: frame.height-kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}
//MARK:监听label的点击
extension PageTitleView{
    @objc fileprivate func titleLabelClick(tapGes :UITapGestureRecognizer){
        //1.获取当前label下标值
        guard let currentLabel = tapGes.view as? UILabel else {
            return
        }
        //2.获取之前label
        let oldLabel = titleLabels[currentIndex]
        if currentLabel.tag == currentIndex{
            return
        }
        //if !currentLabel.isEqual(oldLabel){
            oldLabel.textColor = UIColor.init(r: kNormarlColor.0, g: kNormarlColor.1, b: kNormarlColor.2)
        //}
        //3.切换颜色
        currentLabel.textColor = UIColor.init(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        
        
        //4.保存新label下标值
        currentIndex = currentLabel.tag
        //5.改变滚动条位置
        let scrollLinePositionX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) { 
            self.scrollLine.frame.origin.x = scrollLinePositionX
        }
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}
//MARK： 对外提供方法
extension PageTitleView{
    func setTitleWithProgress(progress : CGFloat ,sourceIndex : Int ,targetIndex : Int){
        //1.取出sourceLabel/targetLabel
        if (sourceIndex >= titleLabels.count || targetIndex >= titleLabels.count) {
            return
        }
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
         
        
        //2.处理滑块
      let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
      let moveX = moveTotalX * progress
      scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //3.颜色的渐变
        //a.取出变化范围
        let colorDelta = (kSelectColor.0 - kNormarlColor.0,kSelectColor.1 - kNormarlColor.1,kSelectColor.2 - kNormarlColor.2)
        //b.变化sourceLabel
        sourceLabel.textColor = UIColor.init(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        //c.变化targetLabel
        targetLabel.textColor = UIColor.init(r: kNormarlColor.0 + colorDelta.0 * progress, g: kNormarlColor.1 + colorDelta.1 * progress, b: kNormarlColor.2 + colorDelta.2 * progress)
        //4.记录最新的Index
        currentIndex = targetIndex
    }
}
