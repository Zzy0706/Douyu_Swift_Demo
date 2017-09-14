//
//  RecommendViewModel.swift
//  Douyu_Swift_Demo
//
//  Created by Eren.Zhang on 2017/9/12.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit

class RecommendViewModel {
    //MARK:懒加载属性
    lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
    lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDatagroup = AnchorGroup.init()
    fileprivate lazy var prettyGroup = AnchorGroup.init()
    
}


//MARK:发送网络请求
extension RecommendViewModel{
    //请求推荐数据
    func requestData(finishCallBack : @escaping ()->()){
        
        //定义参数
        let parameters = ["limit":"4","offset":"0","time":"\(NSDate.getCurrentTime())" as NSString]
        
        //创建Group
        let disGroup = DispatchGroup.init()
        disGroup.enter()
        //1.请求第一部分推荐数据
        NetWorkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", type: .GET, parameters: ["time":"\(NSDate.getCurrentTime())" as NSString]) { (result) in
            //1.将result转为字典类型
            guard let resultDict = result as? [String:NSObject] else{
                return
            }
            //2.根据data 的key获取数组
            guard  let dataArray = resultDict["data"] as? [[String : NSObject]]else{
                return
            }
            //3.遍历字典转为模型对象
            //a.创建组
            
            //b.设置组的属性
            self.bigDatagroup.tag_name = "热门"
            self.bigDatagroup.icon_name = "home_header_hot"
            for dict in dataArray{
                let anchor = AnchorModel.init(dict: dict)
                self.bigDatagroup.anchors.append(anchor)
            }
            //离开组
            disGroup.leave()
           print("0数据请求成功")
        }
        //2.请求第二部分颜值数据
        disGroup.enter()
        NetWorkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", type: .GET, parameters: parameters) { (result) in
            //print(result)
            //1.将result转为字典类型
            guard let resultDict = result as? [String:NSObject] else{
                return
            }
            //2.根据data 的key获取数组
            guard  let dataArray = resultDict["data"] as? [[String : NSObject]]else{
                return
            }
            //3.遍历字典转为模型对象
            
             //b.设置组的属性
            self.prettyGroup.tag_name = "颜值"
           self.prettyGroup.icon_name = "home_header_phone"
            for dict in dataArray{
                let anchor = AnchorModel.init(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            disGroup.leave()
            print("1数据请求成功")
        }
        
        //3.请求(2-12)后面部分的游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=
        disGroup.enter()
        NetWorkTools.requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", type: .GET, parameters: ["limit":"4","offset":"0","time":"\(NSDate.getCurrentTime())" as NSString]) { (result) in
            //1.将result转为字典类型
            guard let resultDict = result as? [String:NSObject] else{
                return
            }
            //2.根据data 的key获取数组
            guard  let dataArray = resultDict["data"] as? [[String : NSObject]]else{
                return
            }
            
            //3.遍历数组，获取字典，将字典转为模型对象
            
            for dict in dataArray{
                let group = AnchorGroup.init(dict: dict)
                self.anchorGroups.append(group)
            }

            disGroup.leave()
            print("(2-12)数据请求成功")
        }
        //当所有数据请求成功后，对数据进行排序
        disGroup.notify(queue: DispatchQueue.main) {
            print("数据请求成功")
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDatagroup, at: 0)
            print(self.anchorGroups.count)
            finishCallBack()
        }
    }
    //请求轮播数据
    func requestCycledata(finishCallBack : @escaping ()->()){
        NetWorkTools.requestData(URLString: "http://www.douyutv.com/api/v1/slide/6", type: .GET, parameters: ["version":"2.542"]) { (result) in
            guard  let resultDict = result as? [String : NSObject] else{
                return
            }
            //根据data的key或获取数据
             guard let dataArray = resultDict["data"] as? [[String : NSObject]] else {
                return
            }
            // 3 字典转模型
            for dict in dataArray {
              self.cycleModels.append(CycleModel(dict: dict))
             
            }

            print(result)
            finishCallBack()
        }
    }
}
