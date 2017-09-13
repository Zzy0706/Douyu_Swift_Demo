//
//  HomeViewController.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/7.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    //MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        
       let titleFrame = CGRect.init(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        
       let titles = ["推荐","游戏","娱乐","趣味"]
        
       let titleView = PageTitleView.init(frame: titleFrame, titles: titles)
       titleView.delegate = self
       return titleView
        
    }()
    fileprivate lazy var pageContentView : PageContentView={ [weak self] in
        
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabbar
        let contentFrame = CGRect.init(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        
        
        for _ in 0..<4{
            let vc = UIViewController.init()
            vc.view.backgroundColor = UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView : PageContentView = PageContentView.init(frame: contentFrame, childVcs: childVcs, parentViewController: self)
       contentView.delagate = self
        
        return contentView
    }()
    //MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.设置UI界面
        setUpUI()
        
        
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK: 设置UI界面
extension HomeViewController{
    fileprivate func setUpUI(){
        automaticallyAdjustsScrollViewInsets = false//关闭UIScrollViewd的内边距调节
        //1.设置导航栏
        setUpNavigationBar()//设置导航栏
        //2.添加TitleView
        view.addSubview(pageTitleView)
        //3.添加contentview
        view.addSubview(pageContentView)
    }
    fileprivate func setUpNavigationBar(){
        
        //1.设置左边的Item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        //2.设置右侧的Item
        let size = CGSize.init(width: 40, height: 40)
        
        
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem.init(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
        let qrcodeItem = UIBarButtonItem.init(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
    
}

//MARK: 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}
//MARK: 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
}
