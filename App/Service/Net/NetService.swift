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
    
    
    /// 获取"电影/电视剧"详情信息
    static func getMovieInfo(movieLink: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.API_DOMAIN + movieLink, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let movieInfo: MovieInfo? = JSONUtil.readModel(jsonObject, key: "movie")
            
            onSuccess(movieInfo)
        }
    }
    
    
    /// 获取下载链接详情信息
    static func getLinkDetailInfo(link: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.API_DOMAIN + link, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let linkDetailInfo: LinkDetalInfo? = JSONUtil.readModel(jsonObject, key: "link_detail")
            
            onSuccess(linkDetailInfo)
        }
    }
    
    
    /// 获取原声大碟详情信息
    static func getOSTInfo(ostLink: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.API_DOMAIN + ostLink, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let ostInfo: OSTInfo? = JSONUtil.readModel(jsonObject, key: "ost")
            
            onSuccess(ostInfo)
        }
    }
    
    
    /// 获取最新电影列表
    /// - parameter page: 分页. 如"p1"表示第1页, "p2"表示第2页. 从"p1"开始索引.
    static func getNewMovie(page: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.NEW_MOVIE + page + "/", values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let movies: [MovieSimpleInfo] = JSONUtil.readModels(jsonObject, key: "movies") ?? []
            
            onSuccess(movies)
        }
    }
    
    
    /// 获取最新电视剧列表
    /// - parameter page: 分页. 如"p1"表示第1页, "p2"表示第2页. 从"p1"开始索引.
    static func getNewTv(page: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.NEW_TV + page + "/", values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let movies: [MovieSimpleInfo] = JSONUtil.readModels(jsonObject, key: "movies") ?? []
            
            onSuccess(movies)
        }
    }
    
    
    /// 获取最新原声大碟列表
    /// - parameter page: 分页. 如"p1"表示第1页, "p2"表示第2页. 从"p1"开始索引.
    static func getNewOST(page: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        NetHelper.get(APIAddress.NEW_OST + page + "/", values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let ostInfos: [OSTSimpleInfo] = JSONUtil.readModels(jsonObject, key: "ost_infos") ?? []
            
            onSuccess(ostInfos)
        }
    }
    
    
    /// 搜索电影
    /// - parameter keyword: 搜索关键字
    /// - parameter page: 分页. 如"p1"表示第1页, "p2"表示第2页. 从"p1"开始索引.
    static func search(keyword: String, page: String, onError: NetError, onFailure: NetFailure, onSuccess: @escaping NetSuccess)
    {
        let url = "\(APIAddress.SEARCH)q_\(keyword)/\(page)/"
        let safeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        NetHelper.get(safeURL, values: nil, onError: onError, onFailure: onFailure) { (jsonObject) in
            
            let movies: [MovieSimpleInfo] = JSONUtil.readModels(jsonObject, key: "movies") ?? []
            
            onSuccess(movies)
        }
    }
}
