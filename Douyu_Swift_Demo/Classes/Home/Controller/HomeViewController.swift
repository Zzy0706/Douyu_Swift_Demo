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
        let btn = UIButton.init()
        btn.setImage(UIImage.init(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        //2.设置右侧的Item
        let historyBtn = UIButton.init()
        historyBtn.setImage(UIImage.init(named: "image_my_history"), for: .normal)
        historyBtn.setImage(UIImage.init(named: "Image_my_history_click"), for: .highlighted)
        historyBtn.sizeToFit()
        let searchBtn = UIButton.init()
        searchBtn.setImage(UIImage.init(named: "btn_search"), for: .normal)
        searchBtn.setImage(UIImage.init(named: "btn_search_clicked"), for: .highlighted)
        searchBtn.sizeToFit()
        let qrcodeBtn = UIButton.init()
        qrcodeBtn.setImage(UIImage.init(named: "Image_scan"), for: .normal)
        qrcodeBtn.setImage(UIImage.init(named: "Image_scan_click"), for: .highlighted)
        qrcodeBtn.sizeToFit()
        let historyItem = UIBarButtonItem.init(customView: historyBtn)
        
        let searchItem = UIBarButtonItem.init(customView: searchBtn)
        
        let qrcodeItem = UIBarButtonItem.init(customView: qrcodeBtn)
        
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
}
