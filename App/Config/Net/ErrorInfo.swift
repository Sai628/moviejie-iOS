//
//  ErrorInfo.swift
//  错误配置信息
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation


struct ErrorInfo
{
    //MARK:- 基本错误信息
    /// 网络错误提示文字
    static let MSG_NETWORK_ERROR = "网络不佳，请重试"
    /// 网络连接超时提示文字
    static let MSG_TIMEOUT_ERROR = "网络连接超时，请重试"
    // 网络请求出错 (状态码为4xx等)
    static let MSG_REQUEST_ERROR = "网络请求出错"
    /// 服务器内部错误提示文字 (状态码为5xx等)
    static let MSG_SERVER_ERROR = "服务器内部出错"
    /// 未知错误提示文字
    static let MSG_UNKNOWN_ERROR = "发生了未知错误"
    
    
    // MARK:- 错误代码
    //------------------  其它错误代号  -------------------//
    /// 接口调用失败（无具体信息）
    static let CODE_UNKNOWN_ERROR = 99999
    
    //------------------  common 模块错误代号  -------------------//
    /// 系统错误
    static let CODE_COMMON_SYS_ERROR = 10000



    //MARK:-
    static let errorInfoMap = [
        
        //common
        CODE_COMMON_SYS_ERROR: "系统错误",
    ]
}
