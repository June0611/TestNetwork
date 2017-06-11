//
//  NetworkRequest.swift
//  TestNetwork
//
//  Created by Nile on 2017/6/9.
//  Copyright © 2017年 Nile. All rights reserved.
//

import Foundation



/// 请求工具类
class NetworkService{
    
    
    /// Get 请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 请求参数
    ///   - complete: 请求回调 -- 回传结果为对象
    class func GetRequest<T:NSObject>(url:String,
                           params:[String:AnyObject]?,
                           complete:@escaping (_ dataModel:T?,_ error:Error?)->()){
        
        RequsetManager.getRequest(url: url, params: params, success: { (result) in
            self.transformModel(result: result, complete: { (resultObj:T?,resultArr:[T]?) in
                complete(resultObj,nil)
            })
        }) { (error) in
            complete(nil,error)
        }
    }
    
    
    
    /// Get请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 请求参数
    ///   - complete: 请求完成回调 -- 回传结果为对象数组
    class func GetRequest<T:NSObject>(url:String,
                           params:[String:AnyObject]?,
                           complete:@escaping (_ dataModelArray:[T]?,_ error:Error?)->()){
        
        RequsetManager.getRequest(url: url, params: params, success: { (result) in
            self.transformModel(result: result, complete: { (resultObj:T?,resultArr:[T]?) in
                complete(resultArr,nil)
            })
        }) { (error) in
            complete(nil,error)
        }
    }
    
    
    
    
    /// Post 请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 请求参数
    ///   - complete: 请求回调 -- 回传结果为对象
    class func PostRequest<T:NSObject>(url:String,
                           params:[String:AnyObject]?,
                           complete:@escaping (_ dataModel:T?,_ error:Error?)->()){
        
        RequsetManager.postRequest(url: url, params: params, success: { (result) in
            self.transformModel(result: result, complete: { (resultObj:T?,resultArr:[T]?) in
                complete(resultObj,nil)
            })
        }) { (error) in
            complete(nil,error)
        }
    }
    
    
    
    /// Post请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 请求参数
    ///   - complete: 请求完成回调 -- 回传结果为对象数组
    class func PostRequest<T:NSObject>(url:String,
                           params:[String:AnyObject]?,
                           complete:@escaping (_ dataModelArray:[T]?,_ error:Error?)->()){
        
        RequsetManager.postRequest(url: url, params: params, success: { (result) in
            self.transformModel(result: result, complete: { (resultObj:T?,resultArr:[T]?) in
                complete(resultArr,nil)
            })
        }) { (error) in
            complete(nil,error)
        }
    }
    
    
    
    
    
    
    
    /// 转换方法
    ///
    /// - Parameters:
    ///   - result: 网络返回数据
    ///   - complete: 转换完成回调
    class func transformModel<T:NSObject>(result:Any?,
                               complete:@escaping (_ result:T?,_ resultArray:[T]?)->()){
        
        
        let jsonStr = self.converNetData(result: result as Any)
        let obj = T.mj_object(withKeyValues: jsonStr)
        var objArr = [T]()
        if T.mj_objectArray(withKeyValuesArray: jsonStr) != nil {
            for item in T.mj_objectArray(withKeyValuesArray: jsonStr) {
                objArr.append(item as! T)
            }
        }
        complete(obj,objArr)
    }
    

    
    
    /// 转换网络数据
    ///
    /// - Parameter result: 网络数据
    /// - Returns: 返回结果
    class func converNetData(result:Any) -> String{
        let respose = String.init(data: result as! Data, encoding: String.Encoding.utf8)
        return self.decreptRespose(respose: respose)

    }
    
    
    /// 解密
    ///
    /// - Parameter respose: 网络数据
    /// - Returns: 解密结果
    class func decreptRespose(respose:String?) -> String{
        
        //自己实现解密
        return respose ?? "{}"
    }
}




/// 请求管理
class RequsetManager :AFHTTPSessionManager {
    
    
    /// 初始化RequsetManager单利
    static let sharedRequestManager:RequsetManager = {
        let instance = RequsetManager()
        instance.requestSerializer.timeoutInterval = 60.0
        //自定义设置请求头
//        instance.requestSerializer.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)
        instance.responseSerializer = AFHTTPResponseSerializer()
        return instance
    }()

    
    
    /// GET请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 请求参数
    ///   - success: 请求成功回调
    ///   - failure: 请求失败回调
    class func getRequest(url:String,
                    params:[String:AnyObject]?,
                    success:@escaping (_ responseData:Any?)->()?,
                    failure:@escaping (_ error:Error)->()?){
        
        RequsetManager.sharedRequestManager.get(url, parameters: params, progress: nil, success: {
            (task:URLSessionDataTask,result:Any?) in
            success(result)
            
        }) { (task:URLSessionDataTask?, error:Error) in
            failure(error)
        }
    }
    
    
    
    /// POST请求
    ///
    /// - Parameters:
    ///   - url: 请求地址
    ///   - params: 请求参数
    ///   - success: 请求成功回调
    ///   - failure: 请求失败回调
    class func postRequest(url:String,
                    params:[String:AnyObject]?,
                    success:@escaping (_ responseData:Any?)->()?,
                    failure:@escaping (_ error:Error)->()?){
        RequsetManager.sharedRequestManager.post(url, parameters: params, progress: nil, success: {
            (task:URLSessionDataTask,result:Any?) in
            success(result)
            
        }) { (task:URLSessionDataTask?, error:Error) in
            failure(error)
        }
    }
}





