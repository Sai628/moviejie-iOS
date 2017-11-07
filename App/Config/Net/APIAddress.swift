//
//  APIAddress.swift
//  API 地址配置信息
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation


class APIAddress
{
    static let API_DOMAIN = "http://api-moviejie.sai628.com:5000"  // API域名
    //static let API_DOMAIN = "http://localhost:5000"  // API域名
    
    /// 最新电影
    static let NEW_MOVIE = API_DOMAIN + "/new/movie/"
    /// 最新电视剧
    static let NEW_TV = API_DOMAIN + "/new/tv/"
    /// 最新原声大碟
    static let NEW_OST = API_DOMAIN + "/new/ost/"
    /// 搜索电影
    static let SEARCH = API_DOMAIN + "/search/"
}
