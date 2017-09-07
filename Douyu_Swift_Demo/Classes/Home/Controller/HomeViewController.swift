//
//  HomeViewController.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/7.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK: 设置UI界面
extension HomeViewController{
     func setUpUI(){
        setUpNavigationBar()//设置导航栏
    }
    private func setUpNavigationBar(){
        
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
