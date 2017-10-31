//
//  OSTInfo.swift
//  原声大碟信息model. 对应URL: /ost/<ost_id>/ 页面中的数据结构
//
//  Created by Sai on 30/10/2017.
//  Copyright © 2017 Sai628.com. All rights reserved.
//

import Foundation

import SwiftyJSON


class OSTInfo: ModelType
{
    var movie_name: String      = ""  // 电影名称
    var movie_link: String      = ""  // 电影详情页面链接
    var banner: String          = ""  // 封面图URL
    var res_name: String        = ""  // 资源名称
    var country: String         = ""  // 地区
    var language: String        = ""  // 语言
    var publish_time: String    = ""  // 发行时间
    var file_type: String       = ""  // 资源格式
    var track_list: [String]    = []  // 专辑曲目列表
    var links: [LinkInfo]       = []  // 下载页面链接列表
    
    
    init()
    {
    }
    
    
    required init?(json: JSON)
    {
        movie_name      = json["movie_name"].stringValue
        movie_link      = json["movie_link"].stringValue
        banner          = json["banner"].stringValue
        res_name        = json["res_name"].stringValue
        country         = json["country"].stringValue
        language        = json["language"].stringValue
        publish_time    = json["publish_time"].stringValue
        file_type       = json["file_type"].stringValue
        track_list      = (json["track_list"].arrayObject as? [String]) ?? []
        links           = JSONUtil.readModels(json["links"]) ?? []
    }
}


extension OSTInfo: JSONDicConvertible, JSONStringConvertible
{
    var jsonDic: JSONDic
    {
        return [
            "movie_name": movie_name,
            "movie_link": movie_link,
            "banner": banner,
            "res_name": res_name,
            "country": country,
            "language": language,
            "publish_time": publish_time,
            "file_type": file_type,
            "track_list": track_list,
            "links": JSONUtil.writeModels(links),
        ]
    }
    
    
    var jsonString: String
    {
        return jsonDic.jsonString
    }
}


extension OSTInfo: CustomStringConvertible
{
    var description: String
    {
        return "OSTInfo:\(jsonString)"
    }
}
