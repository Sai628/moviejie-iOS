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
        NetHelper.get(APIAddress.API_DOMAIN, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let news: [NewInfo] = JSONUtil.readModels(jsonObject, key: "news") ?? []
            let hots: [HotInfo] = JSONUtil.readModels(jsonObject, key: "hots") ?? []
            
            let data: [String: Any] = [
                "news": news,
                "hots": hots
            ]
            
            onSuccess(data)
        }
    }
    
    
    /// 获取"电影/电视剧"信息
    static func getMovieInfo(movieLink: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.API_DOMAIN + movieLink, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let movieInfo: MovieInfo? = JSONUtil.readModel(jsonObject, key: "movie")
            
            onSuccess(movieInfo)
        }
    }
    
    
    /// 获取下载链接
    static func getLinkDetailInfo(link: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.API_DOMAIN + link, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let linkDetailInfo: LinkDetalInfo? = JSONUtil.readModel(jsonObject, key: "link_detail")
            
            onSuccess(linkDetailInfo)
        }
    }
}
