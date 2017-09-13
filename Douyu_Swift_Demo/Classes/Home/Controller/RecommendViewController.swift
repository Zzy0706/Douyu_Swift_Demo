//
//  RecommendViewController.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/11.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW = (kScreenW - 3 * kItemMargin)/2
fileprivate let kNormalItemH = kItemW * 3 / 4
fileprivate let kPrettyItemH = kItemW * 4 / 3
fileprivate let kHeaderViewH : CGFloat = 50
fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"
class RecommendViewController: UIViewController {
    //MARK:懒加载属性
    fileprivate lazy var recommendVM : RecommendViewModel = RecommendViewModel()
    fileprivate lazy var collectionView : UICollectionView = { [unowned self] in
        
       //1.创建布局
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize.init(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize.init(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)//设置内边距
        //2.创建UICollectionView
        let collectionView : UICollectionView = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib.init(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib.init(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        return collectionView
    }()
    
    //MARK:系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor.red
        //2.发送网络请求
        recommendVM.requestData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//MARK:设置UI界面
extension RecommendViewController{
    fileprivate func setupUI(){
        view.addSubview(collectionView)
    }
}
//MARK:请求数据
extension RecommendViewController{
    fileprivate func loadData(){
        NetWorkTools.requestData(URLString: "http://httpbin.org/get", type: .GET, parameters: ["name":"why"]) { (result) in
            print(result)
        }
    }
}

//MARK: 遵守UICollectionViewDataSource协议
extension RecommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell!
        //取出Cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize.init(width: kItemW, height: kPrettyItemH)
        }
        return CGSize.init(width: kItemW, height: kNormalItemH)
    }
}
