//
//  LinkDetailInfo.swift
//  下载链接详情信息model. 对应URL: /link/<link_id>/ 页面中的数据结构
//
//  Created by Sai on 16/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import SwiftyJSON


class LinkDetalInfo: ModelType
{
    var movie_title: String      = ""  // 电影标题
    var movie_link: String       = ""  // 电影/电视剧页面链接
    var name: String             = ""  // 资源名称
    var size: String             = ""  // 资源大小
    var download_link: String    = ""  // 资源下载链接
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        movie_title 	= json["movie_title"].stringValue
        movie_link      = json["movie_link"].stringValue
        name            = json["name"].stringValue
        size            = json["size"].stringValue
        download_link   = json["download_link"].stringValue
    }
}


extension LinkDetalInfo: JSONDicConvertible, JSONStringConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "movie_title": movie_title,
            "movie_link": movie_link,
            "name": name,
            "size": size,
            "download_link": download_link,
        ]
    }
    
    
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}


extension LinkDetalInfo: CustomStringConvertible
{
    var description: String
    {
        return "LinkDetailInfo:\(jsonString)"
    }
}
