//
//  ResourceInfo.swift
//  资源信息model. 对应于首页的"更新/热门"资源数据结构
//
//  Created by Sai on 10/10/17.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import SwiftyJSON


class ResourceInfo: ModelType
{
    var title: String       = ""  // 名称
    var movie_link: String  = ""  // 电影/电视剧页面链接
    var link: String        = ""  // 下载页面链接
    var size: String        = ""  // 大小
    var rating: String      = ""  // 评分
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        title       = json["title"].stringValue
        movie_link  = json["movie_link"].stringValue
        link        = json["link"].stringValue
        size        = json["size"].stringValue
        rating 	    = json["rating"].stringValue
    }
}


extension ResourceInfo: JSONDicConvertible, JSONStringConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "title"     : title,
            "movie_link": movie_link,
            "link"      : link,
            "size"      : size,
            "rating"    : rating,
        ]
    }
    
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}

extension ResourceInfo: CustomStringConvertible
{
    var description: String
    {
        return "ResourceInfo:\(jsonString)"
    }
}
