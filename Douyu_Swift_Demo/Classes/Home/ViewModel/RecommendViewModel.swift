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
    fileprivate lazy var anchorGroups:[AnchorGroup] = [AnchorGroup]()
}


//MARK:发送网络请求
extension RecommendViewModel{
    func requestData(){
        //1.请求第一部分推荐数据
        
        //2.请求第二部分颜值数据
        
        //3.请求后面部分的游戏数据
        //http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=
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
            for group in self.anchorGroups{
                for anchor in group.anchors{
                    print(anchor.nickname!)
                }
                print("------------")
            }
        }
    }
}
