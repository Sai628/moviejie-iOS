//
//  NetHelper.swift
//  网络工具类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias JSONDic = [String: Any?]
typealias Values = Parameters

typealias NetSuccess = (_ data: Any?) -> Void
typealias NetFailure = ((_ failureMsg: String) -> Void)?
typealias NetError = ((_ errorCode: Int, _ errorMsg: String) -> Void)?

typealias NetStringResult = (_ data: String?) -> Void
typealias NetSuccessHandler = (_ jsonObject: JSON) -> Void


enum NetServiceError: Error
{
    case NetError  //网络异常
    case requestError  //请求错误(4xx)
    case serverError  //服务器出错(5xx/6xx)
    case noConnectionError  //无网络连接
    case timeoutError  //请求超时
}


class NetHelper
{
    static let RESULT_STATUS = "status"
    static let RESULT_ERROR = "error"
    static let RESULT_ERROR_CODE = "errorCode"
    
    static let RESULT_SUCCESS = 1
    
    
    //MARK:-
    fileprivate static func handleResponse(_ response: DataResponse<String>, cacheResult: Bool = false, cacheKey: String? = nil,
                                           onError: NetError, onFailure: NetFailure, handler: NetSuccessHandler)
    {
        guard let res = response.response else
        {
            dealWithFailure(.NetError, onFailure: onFailure)
            return
        }
        
        switch res.statusCode
        {
        case 200..<300:  //请求成功
            handleResponseValue(response.result.value!, cacheResult: cacheResult, cacheKey: cacheKey, onError: onError, successHandler: handler)
            
        case 400..<500:  //请求错误
            dealWithFailure(.requestError, onFailure: onFailure)
            
        case 500..<700:  //服务器错误
            dealWithFailure(.serverError, onFailure: onFailure)
            
        default:
            dealWithFailure(.NetError, onFailure: onFailure)
        }
    }
    
    
    fileprivate static func handleResponseValue(_ value: String, cacheResult: Bool = false, cacheKey: String? = nil,
                                                onError: NetError, successHandler: NetSuccessHandler)
    {
        let jsonObject = JSON(parseJSON: value)
        if !tryToHandleError(jsonObject, onError: onError)
        {
            successHandler(jsonObject)
            if cacheResult, let cacheKey = cacheKey  // 若需对请求结果进行缓存时, 将其添加到全局缓存中
            {
                try? apiStorage.setObject(value, forKey: cacheKey, expiry: .date(Date().addingTimeInterval(Constant.CACHE_EXPIRE_TIME)))
            }
        }
    }
    
    
    fileprivate static func isSuccess(_ jsonObject: JSON) -> Bool
    {
        if let status = jsonObject[RESULT_STATUS].int
        {
            return (status == RESULT_SUCCESS)
        }
        
        return false
    }
    
    
    static func tryToHandleError(_ jsonObject: JSON, onError: NetError) -> Bool
    {
        guard !isSuccess(jsonObject) else
        {
            return false
        }
        
        guard let errorCode = jsonObject[RESULT_ERROR_CODE].int else
        {
            dealWithError(ErrorInfo.CODE_UNKNOWN_ERROR, errorMsg: ErrorInfo.MSG_UNKNOWN_ERROR, onError: onError)
            return true
        }
        
        let errorMsg = ErrorInfo.errorInfoMap[errorCode] ?? ErrorInfo.MSG_UNKNOWN_ERROR
        dealWithError(errorCode, errorMsg: errorMsg, onError: onError)
        return true
    }
    
    
    static func dealWithError(_ errorCode: Int, errorMsg: String, onError: NetError)
    {
        onError?(errorCode, errorMsg)
    }
    
    
    static func dealWithFailure(_ error: NetServiceError, onFailure: NetFailure)
    {
        var msg = ErrorInfo.MSG_UNKNOWN_ERROR
        
        switch error
        {
        case .NetError:
            msg = ErrorInfo.MSG_NETWORK_ERROR
            
        case .requestError:
            msg = ErrorInfo.MSG_REQUEST_ERROR
            
        case .serverError:
            msg = ErrorInfo.MSG_SERVER_ERROR
            
        case .noConnectionError:
            msg = ErrorInfo.MSG_NETWORK_ERROR
            
        case .timeoutError:
            msg = ErrorInfo.MSG_TIMEOUT_ERROR
        }
        
        log.error("\(error), \(msg)")
        onFailure?(msg)
    }
    
    
    //MARK:-
    static func get(_ url: String, values: Values?, cacheResult: Bool = false,
                    onError: NetError, onFailure: NetFailure, successHandler: @escaping NetSuccessHandler)
    {
        request(url, method: .get, values: values, cacheResult: cacheResult, onError: onError, onFailure: onFailure, successHandler: successHandler)
    }
    
    
    static func post(_ url: String, values: Values?, onError: NetError, onFailure: NetFailure, successHandler: @escaping NetSuccessHandler)
    {
        request(url, method: .post, values: values, onError: onError, onFailure: onFailure, successHandler: successHandler)
    }
    
    
    static func request(_ url: String, method: HTTPMethod, values: Values?, cacheResult: Bool = false,
                        onError: NetError, onFailure: NetFailure, successHandler: @escaping NetSuccessHandler)
    {
        log.info("URL: \(url)")
        log.info("parameter: \(String(describing: values))")
        
        // 若这个请求需要进行缓存时, 先尝试从全局缓存中获取数据
        if cacheResult, let entry = try? apiStorage.entry(ofType: String.self, forKey: url)
        {
            if entry.expiry.isExpired {
                log.info("找到缓存数据, 不过已过期. 将重新请求")
                try? apiStorage.removeObject(forKey: url)  // 将当前过期的缓存删除掉
            } else {
                log.info("找到缓存数据.")
                let jsonObject = JSON(parseJSON: entry.object)
                successHandler(jsonObject)
                return
            }
        }
        
        Alamofire.request(url, method: method, parameters: values).responseString { response in
            
            log.info("response: \(url)")
            log.info("response: \(response.result.value ?? "")")
            
            switch response.result
            {
            case .success(_):
                handleResponse(response, cacheResult: cacheResult, cacheKey: url, onError: onError, onFailure: onFailure, handler: successHandler)
                
            case .failure(let error):
                log.error("error: \(error)")
                dealWithFailure(.NetError, onFailure: onFailure)
            }
        }
    }
    
    
    static func requestString(_ url: String, method: HTTPMethod, values: Values?, onResult: @escaping NetStringResult)
    {
        log.info("URL: \(url)")
        log.info("parameter: \(String(describing: values))")
        
        Alamofire.request(url, method: method, parameters: values).validate(statusCode: 200..<300).responseString { response in
            
            log.info("response: \(url)")
            log.info("response: \(response.result.value ?? "")")
            
            switch response.result
            {
            case .success(let value):
                onResult(value)
                
            case .failure(let error):
                log.error("error: \(error)")
                onResult(nil)
            }
        }
    }
}
