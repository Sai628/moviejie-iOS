//
//  NetService.swift
//  网络服务类
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation


class NetService
{
    /// 获取"首页"信息
    static func getIndexInfo(onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.post(APIAddress.API_DOMAIN, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            onSuccess(nil)
        }
    }
    
    
    /// 获取"电影/电视剧"信息
    static func getMovieInfo(movieLink: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.API_DOMAIN + movieLink, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            onSuccess(nil)
        }
    }
    
    
    /// 获取下载链接
    static func getDownloadLink(link: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.API_DOMAIN + link, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            onSuccess(nil)
        }
    }
}
