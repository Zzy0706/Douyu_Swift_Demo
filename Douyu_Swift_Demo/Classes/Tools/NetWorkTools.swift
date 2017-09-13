//
//  NetWorkTools.swift
//  Alamofire_Demo
//
//  Created by Eren.Zhang on 2017/9/12.
//  Copyright © 2017年 com.zzy0706.io. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case GET
    case POST
}

class NetWorkTools {
    class func requestData(URLString : String,type : MethodType,parameters : [String : NSString]? = nil,finishedCallback : @escaping (_ result : AnyObject)->()){
        //1.获取类型
        let methodNow : HTTPMethod = type == .GET ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(URLString, method: methodNow, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            guard let reult2 = response.result.value else{
                print(response.result.error!)
                return
            }
            finishedCallback(reult2 as AnyObject)
        }
        }
    }

